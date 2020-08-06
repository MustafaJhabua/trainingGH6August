/*

*@author Siva

*@date 2/27/2020 

*@description DelayedCaseController

*@History

  Author  - Date - Description
  Devendra - 05/01/2020 - ENT-16312 : Modify 'Create Delayed Case' button so that due date doesn't autopopulate
*/

public class DelayedCaseController {

    // Constructor - this only really matters if the autoRun function doesn't work right
    private final Guardant_360_Sample__c o;
    public DelayedCaseController(ApexPages.StandardController stdController) {
        this.o = (Guardant_360_Sample__c) stdController.getRecord();
    }

    // Code we will invoke on page load.
    public PageReference autoRun() {
        case cs;
        Guardant_360_Sample__c gSample;
        String theId = ApexPages.currentPage().getParameters().get('id');
    
        if(theId == null){
            return null;
        }
        List <case> csList = [select id from case where Guardant_360_Sample__c =: theId and subject = 'Delayed Sample'];
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@' + csList.size());
        if(csList.size() == 0){
            Id technicalCaseRTId = SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Technical_Case').getRecordTypeId();
    
            for (Guardant_360_Sample__c gs: [select id, name, account__c, contact__c from Guardant_360_Sample__c where id =: theId]) {
            cs = new
            case (BusinessHoursid = label.businesshour, Accession_No__c = gs.name, accountid = gs.account__c, Action__c = 'TAT ALERT', ContactID = gs.contact__c,
             Guardant_360_Sample__c = gs.id, Initiated__c = 'TAT ALERT-Internal', Origin = 'Internal', ownerid = '00G80000002vLPH', Priority = 'Medium', recordtypeid = technicalCaseRTId, Status = 'New',
             Subject = 'Delayed Sample', Technical_Reason__c = 'Lab Issue', Technical_Type__c = 'TAT ALERT');
            }
            insert cs;
            DelayedCaseCheckbox.updatingSample(theId);
            
            // Redirect the user back to the original page
            PageReference pageRef = new PageReference('/' + cs.id);
            pageRef.setRedirect(true);
            return pageRef;
        }else{
            PageReference pageRef = new PageReference('/' + theID);
            pageRef.setRedirect(true);
            return pageRef;
        }
    }
}