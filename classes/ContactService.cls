//this class leverages without sharing due to the update of last email date needing to happen on contacts where the email does not always come from the owner
public without sharing class ContactService {
    public List<Contact> unQualifiedContacts;
    public Set<String> qualifiedContactEmails;
    public List<Contact> marketableContactToUpdate;
    public Set<String> qualifiedContactEmailWithDuplicateEmails;
    public static final Set<String> MARKETABLE_CONTACT_ROLES = new Set<String>{
            'Surgical Oncologist',
            'Pediatric Oncologist',
            'Radiation Oncologist',
            'Hematologist',
            'Medical Oncologist',
            'General MD',
            'Gynecologic Oncologist',
            'Nurse Practitioner'
    };

    public void markContactMarketable(List<Contact> contacts){
        unQualifiedContacts = new List<Contact>();
        qualifiedContactEmails = new Set<String>();
        marketableContactToUpdate = new List<Contact>();
        qualifiedContactEmailWithDuplicateEmails = new Set<String>();
        for (Contact contact : contacts) {
            if(contact.Email == null){
                if(contact.Marketable_User__c){
                    contact.Marketable_User__c = false;
                    unQualifiedContacts.add(contact);
                }
                continue; //ignore those without an email
            }
            
             if(contact.Account_Type__c != 'Clinical Account US' && contact.Marketable_User__c){
                    contact.Marketable_User__c = false;
                    unQualifiedContacts.add(contact);
                    continue;
            }
            if(contact.Number_of_Samples__c >0 && contact.Unqualified_by_CS__c){
                if(contact.Marketable_User__c){
                    contact.Marketable_User__c = false;
                    unQualifiedContacts.add(contact);
                }
                continue;
            }
            if(!checkIfQualifiedRole(contact)){
                if(contact.Marketable_User__c){
                    contact.Marketable_User__c = false;
                    unQualifiedContacts.add(contact);
                }
                continue;
            }
            //qualifiedContacts.add(contact);
            qualifiedContactEmails.add(contact.Email);
            //System.debug('qualified emails'+qualifiedContactEmails);
        }
        //get all the contacts with matching emails and sort by email/#samples/sampledate/createdDate. mark first one
        //as marketable contact
        List<Contact> sortedQualifiedContactsByEmail = ContactSelector.qualifiedContactsSortedByNpiAndEmailAndSampleCount(qualifiedContactEmails);
        String currentEmail = '';
        Id currentNPI;
        for (Contact contact : sortedQualifiedContactsByEmail) {
            //System.debug('currentNPI: '+ currentNPI);
            //System.debug('this record NPI: '+ contact.Actual_NPI__c);
            if(contact.Actual_NPI__c != null && contact.Actual_NPI__c == currentNPI){
                contact.Marketable_User__c = false;
                continue;
            }
            if(contact.Email == currentEmail){
                contact.Marketable_User__c = false;
                continue;
            }
            
           
            contact.Marketable_User__c = true;
             if(contact.Email == null){
                contact.Marketable_User__c = false;
                continue;
            }
            currentEmail = contact.Email;
            currentNPI = contact.Actual_NPI__c;
        }
        Log.debug('Contact Count to Update Qualified: '+String.valueOf(sortedQualifiedContactsByEmail.size()));
        Log.debug('Contact Count to Update UnQualified: '+String.valueOf(unQualifiedContacts.size()));
        Database.update(sortedQualifiedContactsByEmail,false);
        Database.update(unQualifiedContacts,false);
    }


    public static Boolean checkIfQualifiedRole(Contact con){
        return MARKETABLE_CONTACT_ROLES.contains(con.Contact_Role__c);
    }


    public static void updateContactEmailDate(Map<Id,Date> contactIdEmailDate){
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Id id : contactIdEmailDate.keySet()) {
            contactsToUpdate.add(new Contact(Id = id, Last_Email_Date__c = contactIdEmailDate.get(id)));
        }
        if(contactsToUpdate.size()>0){
            update contactsToUpdate;
        }
    }

}