global class requestaKitFormController {
    
   
    @RemoteAction
   global static String FormDetails(string str) {
          try{
          
              string npinumber = str.split(';#')[2];
              string emailstr = str.split(';#')[3];
              system.debug('emailstr#############'+emailstr);
              system.debug('npinumber#############'+npinumber);
              if(npinumber.length() != 10){
              return 'Error';
              }

              contact conRef = new contact();
              for(contact con : [select id,email,npi_number__c from contact where (NPI_Number__c =:npinumber or email =:emailstr or ActualNPINumber__c =:npinumber) and Account_Qualified__c = true limit 1]){
                system.debug('Contactrecord**************'+con);
                 if(con != null){
                 conRef = con;
                 }
              }
             // system.debug('@@@@@@@@@@@@@@@@@@@@@@'+conref);
              // If a contact is matched with NPI number or email
              if(conRef != new contact()){
                 // conRef.FirstName = str.split(';#')[0];
                 // conRef.LastName = str.split(';#')[1];
                 // conRef.NPI_Number__c = str.split(';#')[2] ;
                 // conRef.Email = str.split(';#')[3] ;
                  conRef.Practice_Contact_First_Name__c = str.split(';#')[4];
                  conRef.Practice_Contact_Last_Name__c = str.split(';#')[5];
                  if(conRef.npi_number__c == str.split(';#')[2]){
                  conRef.NPI_Matched__c = true;
                  }
                  conRef.Practice_Office_Contact_Email__c = str.split(';#')[6] ;
                  conRef.Request_a_Kit_Practice_Address__c =  str.split(';#')[8];
                  conRef.Request_a_Kit_Practice_City__c =  str.split(';#')[9];
                  conRef.Request_a_Kit_Practice_Name__c = str.split(';#')[7];
                  conRef.Request_a_Kit_Practice_State__c =  str.split(';#')[10];
                  conRef.Request_a_Kit_Practice_Zip__c =  str.split(';#')[11];
                  conRef.No_Of_Kits__c =  str.split(';#')[12];
                 // conRef.AccountName = str.split(';#')[7];
                 // conRef.mailingstreet = str.split(';#')[8];
                 // conRef.mailingpostalcode = str.split(';#')[11];
                 // conRef.mailingcity = str.split(';#')[9];
                 // conRef.mailingstate= str.split(';#')[10];
                  conRef.Request_a_Kit_Details__c = str.split(';#')[0]+','+str.split(';#')[1]+','+str.split(';#')[2]+','+
                                                    str.split(';#')[3]+','+str.split(';#')[4]+','+str.split(';#')[5]+','+
                                                    str.split(';#')[6]+','+str.split(';#')[7]+','+str.split(';#')[8]+','+
                                                    str.split(';#')[9]+','+str.split(';#')[10]+','+str.split(';#')[11]+','+str.split(';#')[12];
                  conRef.Requestakit__c=true;
                  update conRef;
              } 
              //If there is no match for npi number and email then it will create lead
              else{
              
              lead leadRef= new lead(Physician_First_Name__c = str.split(';#')[0],lastname =str.split(';#')[1] ,company = str.split(';#')[7],Physician_Last_Name__c = str.split(';#')[1],NPI_Number__c = str.split(';#')[2],NPI_Not_Matched__c  = true,
                                                                   Email=str.split(';#')[3],Practice_Contact_First_Name__c = str.split(';#')[4],Practice_Contact_Last_Name__c = str.split(';#')[5],
                                                                   Practice_Office_Contact_Email__c = str.split(';#')[6],Clinic_Name__c = str.split(';#')[7],street = str.split(';#')[8],
                                                                   postalcode = str.split(';#')[11],Requestakit__c=true,city = str.split(';#')[9],state= str.split(';#')[10],Inquiry_Type__c = 'New Medical Professional',No_Of_Kits__c =  str.split(';#')[12]);     
              leadRef.Request_a_Kit_Details__c =    str.split(';#')[0]+','+str.split(';#')[1]+','+str.split(';#')[2]+','+
                                                    str.split(';#')[3]+','+str.split(';#')[4]+','+str.split(';#')[5]+','+
                                                    str.split(';#')[6]+','+str.split(';#')[7]+','+str.split(';#')[8]+','+
                                                    str.split(';#')[9]+','+str.split(';#')[10]+','+str.split(';#')[11]+','+str.split(';#')[12];                                                        
              insert  leadRef;
              }
              
             /*  Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
    
               Step 1: Set list of people who should get the email
              List<String> sendTo = new List<String>();
              sendTo = label.Clientservice_Email.split(';');
               mail.setToAddresses(sendTo);
            
              
              Step 2. Set email contents 
              mail.setSubject('Request a kit submitted by Portal');
              
              String body = 'Environment:';
              body += '\n'+'Request a kit details updated in Portal:';
              
              mail.setHtmlBody(body);
                
          
              Step 3: Send all emails in the master list
              Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); */
              return 'Success';
          
          }
          catch(exception ex){
                    system.debug('@@@@@@@@@@@@@@@'+ex.getmessage());

          return 'Error';
          }
        
    }
    
    
}