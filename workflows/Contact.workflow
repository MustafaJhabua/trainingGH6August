<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account_Contact_Updated</fullName>
        <description>Account Contact Updated</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/Stark_Law_1</template>
    </alerts>
    <alerts>
        <fullName>Contact_AE_modified_address_of_Qualified_contact</fullName>
        <ccEmails>ablair@guardanthealth.com</ccEmails>
        <description>Contact: AE modified address of Qualified contact</description>
        <protected>false</protected>
        <recipients>
            <field>RSD_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>Manager_Client_Services</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/Contact_Address_modified_by_AE</template>
    </alerts>
    <alerts>
        <fullName>Email_to_AE</fullName>
        <description>Automated email sent. Please contact via phone. Once account verified, request qualification.</description>
        <protected>false</protected>
        <recipients>
            <recipient>ablair@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Client_Services_Email_Templates/Email_to_AE</template>
    </alerts>
    <alerts>
        <fullName>Email_to_AE_for_New_Physician</fullName>
        <description>Automated email sent.  Please contact via phone.  Once account verified, request qualification.</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_to_AE_for_New_Physician</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Client_Services_Dept</fullName>
        <ccEmails>DL-Client-Services@guardanthealth.com</ccEmails>
        <description>Email to Client Services Dept</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_to_Client_Services_Dept</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Med_Affairs</fullName>
        <description>Assign to Med Affairs User</description>
        <protected>false</protected>
        <recipients>
            <recipient>matasks@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_to_Med_Affairs</template>
    </alerts>
    <alerts>
        <fullName>Inform_Sales_that_Physician_Has_Churned_30_Days</fullName>
        <description>Inform Sales that Physician Has Churned 30 Days</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/Churned_Physician_30_Days</template>
    </alerts>
    <alerts>
        <fullName>Qualified_Email_Update_with_Portal_Account</fullName>
        <description>Sent when the email field on a Qualified Contact with a portal account is modified by Sales, CS, or CTA</description>
        <protected>false</protected>
        <recipients>
            <recipient>Client_Services_Associate</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Manager_Client_Services</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>UE_Email_Folder/Qualified_Email_Update</template>
    </alerts>
    <alerts>
        <fullName>Secondary_Email_Field_Updated_to_CS</fullName>
        <description>TEST. Sent when the secondary email field on a Contact is modified by force.com-Biopharma</description>
        <protected>false</protected>
        <recipients>
            <recipient>Client_Services_Associate</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>Manager_Client_Services</recipient>
            <type>role</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>UE_Email_Folder/Secondary_Email_Update</template>
    </alerts>
    <alerts>
        <fullName>Send_SL_Email_1</fullName>
        <description>Send SL Email 1</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <field>Account_AM_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Account_BD_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>RSD_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Stark_Law_Alerts/SL_80_percent</template>
    </alerts>
    <alerts>
        <fullName>Send_SL_Email_2</fullName>
        <ccEmails>Medical_Affairs@guardanthealth.com</ccEmails>
        <description>Send SL Email 2</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <field>Account_AM_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Account_BD_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>RSD_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Stark_Law_Alerts/SL_85_percent</template>
    </alerts>
    <alerts>
        <fullName>Send_SL_Email_3</fullName>
        <ccEmails>Medical_Affairs@guardanthealth.com</ccEmails>
        <description>Send SL Email 3</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <field>Account_AM_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Account_BD_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>RSD_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>kdennis@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmccoy@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Stark_Law_Alerts/SL_90_percent</template>
    </alerts>
    <alerts>
        <fullName>X10_Guardant_Challenge_Sample_by_Physician_Notification</fullName>
        <ccEmails>nsheehy@guardanthealth.com</ccEmails>
        <description>10+ Guardant Challenge Sample by Physician Notification</description>
        <protected>false</protected>
        <recipients>
            <field>RSD_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>pspitzer@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rsmith@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/CH1_Notification_10</template>
    </alerts>
    <alerts>
        <fullName>X1st_Sample_submitted_by_Physician</fullName>
        <description>1st Sample submitted by Physician</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <recipients>
            <recipient>ablair@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>clee@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/X1st_Sample_Physician_Notice</template>
    </alerts>
    <alerts>
        <fullName>sendingEmailToCSTeam</fullName>
        <ccEmails>clientservices@guardanthealth.com</ccEmails>
        <description>sendingEmailToCSTeam</description>
        <protected>false</protected>
        <recipients>
            <recipient>kashton@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>cdaglow@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/ContactUpdateOnRequestAkit</template>
    </alerts>
    <fieldUpdates>
        <fullName>AE_Notification_Date</fullName>
        <field>First_Sample_AE_Email_Notification__c</field>
        <formula>Today()</formula>
        <name>AE Notification Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Autofill_Date</fullName>
        <field>Stale_Tester_Date__c</field>
        <formula>TODAY()</formula>
        <name>Autofill Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Contact_Status</fullName>
        <field>Contact_Status__c</field>
        <literalValue>Inactive</literalValue>
        <name>Change Contact Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Checkbox_fill</fullName>
        <field>Stale__c</field>
        <literalValue>1</literalValue>
        <name>Checkbox fill</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Notification_Date_to_Sales</fullName>
        <field>AE_Notified_Physician_Churned__c</field>
        <name>Clear Notification Date to Sales</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_Notes_about_MD</fullName>
        <description>Update field Notes About MD</description>
        <field>Notes_about_MD__c</field>
        <formula>Notes_about_MD_2__c +  BR() +  PRIORVALUE(  Notes_about_MD__c )</formula>
        <name>Contact: Notes about MD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Expense_Email_Sent</fullName>
        <description>Enter Date once Email re: Expense is sent</description>
        <field>Expense_Email_Sent__c</field>
        <formula>TODAY()</formula>
        <name>Expense Email Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fill_Address_Change_Dtae</fullName>
        <field>Date_Address_Last_Changed__c</field>
        <formula>Today()</formula>
        <name>Fill Address Change Dtae</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fill_SL_Threshold_Date</fullName>
        <field>Exceeded_SL_Limit_Threshold_Date__c</field>
        <formula>TODAY()</formula>
        <name>Fill SL Threshold Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NY_Sample_Check_Contact</fullName>
        <field>New_York_Sample__c</field>
        <literalValue>1</literalValue>
        <name>NY Sample Check Contact</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Remove_Check_Mark</fullName>
        <description>Account Contact Updated, Email notification sent. Resting field to False</description>
        <field>Account_Contact_Updated__c</field>
        <literalValue>0</literalValue>
        <name>Remove Check Mark</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UncheckRequestAKit</fullName>
        <field>Requestakit__c</field>
        <literalValue>0</literalValue>
        <name>UncheckRequestAKit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Churned_Checkbox</fullName>
        <field>Churned__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Churned Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_BD_Owner_EMail</fullName>
        <field>Account_BD_Owner_Email__c</field>
        <formula>CASE(Account_BD_Owner__c, 
&apos;Alexandra Franovic&apos;, &apos;afranovic@guardanthealth.com&apos;, 
&apos;Brenton Foretich&apos;, &apos;bforetich@guardanthealth.com&apos;, 
&apos;Chris Dankulich&apos;, &apos;cdankulich@guardanthealth.com&apos;, 
&apos;Daniel Simon&apos;, &apos;dsimon@guardanthealth.com&apos;, 
&apos;Dhiren Belur&apos;, &apos;dbelur@guardanthealth.com&apos;, 
&apos;Jeshaune Jackson&apos;, &apos;jjackson@guardanthealth.com&apos;, 
&apos;Jess Riley&apos;, &apos;jriley@guardanthealth.com&apos;, 
&apos;Kapil Jain&apos;, &apos;kjain@guardanthealth.com&apos;, 
&apos;Manasa Chandra&apos;, &apos;mchandra@guardanthealth.com&apos;, 
&apos;Maxim Schillebeeckx&apos;, &apos;mschillebeeckx@guardanthealth.com&apos;, 
&apos;Melissa Gebhardt&apos;, &apos;mgebhardt@guardanthealth.com&apos;, 
&apos;Nnamdi Ihuegbu&apos;, &apos;nihuegbu@guardanthealth.com&apos;, 
&apos;Shantanu Mittal&apos;, &apos;smittal@guardanthealth.com&apos;, 
&apos; &apos;)</formula>
        <name>Update Contact BD Owner EMail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_CMS_Study_Enrollment_Date</fullName>
        <field>CMS_Study_Enrollment__c</field>
        <formula>Today()</formula>
        <name>Update CMS Study Enrollment Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Churned_Checkbox</fullName>
        <field>Churned__c</field>
        <literalValue>1</literalValue>
        <name>Update Churned Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Contact_AM_Owner_EMail</fullName>
        <field>Account_AM_Owner_Email__c</field>
        <formula>CASE(Account_AM_Owner__c, 
&apos;Alexandra Franovic&apos;, &apos;afranovic@guardanthealth.com&apos;, 
&apos;Brenton Foretich&apos;, &apos;bforetich@guardanthealth.com&apos;, 
&apos;Chris Dankulich&apos;, &apos;cdankulich@guardanthealth.com&apos;, 
&apos;Daniel Simon&apos;, &apos;dsimon@guardanthealth.com&apos;, 
&apos;Dhiren Belur&apos;, &apos;dbelur@guardanthealth.com&apos;, 
&apos;Jeshaune Jackson&apos;, &apos;jjackson@guardanthealth.com&apos;, 
&apos;Jess Riley&apos;, &apos;jriley@guardanthealth.com&apos;, 
&apos;Kapil Jain&apos;, &apos;kjain@guardanthealth.com&apos;, 
&apos;Manasa Chandra&apos;, &apos;mchandra@guardanthealth.com&apos;, 
&apos;Maxim Schillebeeckx&apos;, &apos;mschillebeeckx@guardanthealth.com&apos;, 
&apos;Melissa Gebhardt&apos;, &apos;mgebhardt@guardanthealth.com&apos;, 
&apos;Nnamdi Ihuegbu&apos;, &apos;nihuegbu@guardanthealth.com&apos;, 
&apos;Shantanu Mittal&apos;, &apos;smittal@guardanthealth.com&apos;, 
&apos;Alexander Kuklin&apos;, &apos;akuklin@guardanthealth.com&apos;,
&apos;Ali Mukherjee&apos;, &apos;amukherjee@guardanthealth.com&apos;,
&apos; &apos;)</formula>
        <name>Update Contact AM Owner EMail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Fax_with_Account_Fax</fullName>
        <field>Fax</field>
        <formula>Account.Fax</formula>
        <name>Update Fax with Account Fax</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Previous_Last_Sample_Date</fullName>
        <field>Previous_Last_Sample_Date__c</field>
        <formula>PRIORVALUE( Last_Sample_Date__c )</formula>
        <name>Update Previous Last Sample Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Promo_Date_Field</fullName>
        <field>CH1_Promo_Exceeded_Notification_Date__c</field>
        <formula>TODAY()</formula>
        <name>Update Promo Date Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_RDS_Email</fullName>
        <field>RSD_Email__c</field>
        <formula>Owner.Manager.Email</formula>
        <name>Update RDS Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_SL_Notifier</fullName>
        <field>SL_Contact_Notifier_1__c</field>
        <literalValue>1</literalValue>
        <name>Update SL Notifier</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_SL_Notifier_2</fullName>
        <field>SL_Contact_Notifier_2__c</field>
        <literalValue>1</literalValue>
        <name>Update SL Notifier 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_SL_Notifier_3</fullName>
        <field>SL_Contact_Notifier_3__c</field>
        <literalValue>1</literalValue>
        <name>Update SL Notifier 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stale</fullName>
        <field>Stale__c</field>
        <literalValue>0</literalValue>
        <name>Update Stale</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stale_tester_date</fullName>
        <field>Stale_Tester_Date__c</field>
        <name>Update Stale tester date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Training_Date</fullName>
        <field>Training_Date__c</field>
        <formula>Today()</formula>
        <name>Update Training Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_of_last_and_previous_sample_las</fullName>
        <field>of_days_betweenlast_vs_previous_sample__c</field>
        <formula>Last_Sample_Date__c  - Previous_Last_Sample_Date__c</formula>
        <name>Update # of last and previous sample las</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>X30Day_Churn_AE_Notification</fullName>
        <field>AE_Notified_Physician_Churned__c</field>
        <formula>TODAY()</formula>
        <name>30Day Churn AE Notification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>AE modifies Qualified Email</fullName>
        <actions>
            <name>Qualified_Email_Update_with_Portal_Account</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sent to CS whenever an AE or CTA user changes email address of a user with a Portal Account</description>
        <formula>AND(  
ISCHANGED(Email),   
OR(
BEGINS(LastModifiedBy.Profile.Name, &apos;GHI Sales&apos;),
BEGINS(LastModifiedBy.Profile.Name, &apos;Force-Biopharma&apos;)),
NOT(ISBLANK(Portal_User_Name__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Account Contact Updated</fullName>
        <actions>
            <name>Account_Contact_Updated</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Expense_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Remove_Check_Mark</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Account_Contact_Updated__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Workflow will trigger Email notification once (Account Contact Updated) box is Checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Address Change</fullName>
        <actions>
            <name>Fill_Address_Change_Dtae</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Date captured when address, email, fax, or phone is changed</description>
        <formula>ISCHANGED (MailingStreet ) || 
ISCHANGED (MailingCity) || 
ISCHANGED (MailingState) || 
ISCHANGED (MailingCountry) || 
ISCHANGED (MailingPostalCode) ||
ISCHANGED (Phone) ||
ISCHANGED (Fax) ||
ISCHANGED (Email)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Auto Fill Fax from Account</fullName>
        <actions>
            <name>Update_Fax_with_Account_Fax</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/1/2015</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Auto Fill Training Date</fullName>
        <actions>
            <name>Update_Training_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Qualified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Training_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Training Date = Date Qualification Box is Checked</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Auto update the Stale and date</fullName>
        <actions>
            <name>Update_Stale</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Stale_tester_date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Days_Since_Last_Sample__c</field>
            <operation>lessThan</operation>
            <value>365</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Stale__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Stale_Tester_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>BioPharma profile modifies Secondary Email</fullName>
        <actions>
            <name>Secondary_Email_Field_Updated_to_CS</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Sent to CS whenever a user with Force.com-BioPharma profile changes the Secondary email address</description>
        <formula>AND(  ISCHANGED(Secondary_Email__c),   
BEGINS(LastModifiedBy.Profile.Name, &apos;Force-BioPharma&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>CMS Date Auto Fill</fullName>
        <actions>
            <name>Update_CMS_Study_Enrollment_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.CMS_Study__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.CMS_Study_Enrollment__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Capture a previous value of Last Sample Date</fullName>
        <actions>
            <name>Update_Previous_Last_Sample_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>NS:08/09/18 This workflow will fire when there is change on Last sample date and it is not blank.</description>
        <formula>AND( 
ISCHANGED(   Last_Sample_Date__c  ), 
NOT(ISBLANK(   Last_Sample_Date__c   )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Churned Update</fullName>
        <actions>
            <name>Update_Churned_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Qualified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Days_Since_Last_Sample__c</field>
            <operation>greaterThan</operation>
            <value>89</value>
        </criteriaItems>
        <description>Updates Churned checkbox when the days since last sample is greater than 89.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clear 30 Day Churn Notification %28Sales%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Days_Since_Last_Sample__c</field>
            <operation>lessThan</operation>
            <value>30</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.AE_Notified_Physician_Churned__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Clear_Notification_Date_to_Sales</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Contact%3A Update Notes about MD</fullName>
        <actions>
            <name>Contact_Notes_about_MD</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Contact field Notes about MD with values from Outreach Activity via field Contact: Notes about MD2</description>
        <formula>ISCHANGED(  Notes_about_MD_2__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Deactivate Customer</fullName>
        <actions>
            <name>Change_Contact_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Contact_was_unqualified_by_CS</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Unqualified_by_CS__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This will change status to Inactive once the Unqualified Checkbox is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Inform Sales of 1st Sample Submitted</fullName>
        <actions>
            <name>X1st_Sample_submitted_by_Physician</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>AE_Notification_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Physician_has_submitted_their_1st_Guardant_Sample</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.First_Sample_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.First_Sample_AE_Email_Notification__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.First_Sample_Date__c</field>
            <operation>greaterThan</operation>
            <value>4/19/2020</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Owner_ID__c</field>
            <operation>notEqual</operation>
            <value>00580000005tz8w</value>
        </criteriaItems>
        <description>Inform sales that physician has submitted their 1st sample.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NPI Change alert</fullName>
        <actions>
            <name>NPI_Number_Changed</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>Deactivated--moved to Process Builder. Creates task for sysadmins when NPI number is changed for qualified contact</description>
        <formula>AND( 
ISCHANGED(NPI_Number__c), 
Qualified__c = TRUE,
$UserRole.Id &lt;&gt; &apos;00E80000001JYP6&apos;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NY Sample Check Contact</fullName>
        <actions>
            <name>NY_Sample_Check_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.BillingState</field>
            <operation>equals</operation>
            <value>NY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.New_York_Sample__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Not Churned Update</fullName>
        <actions>
            <name>Uncheck_Churned_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Qualified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Days_Since_Last_Sample__c</field>
            <operation>lessThan</operation>
            <value>90</value>
        </criteriaItems>
        <description>Updates Churned checkbox when the days since last sample is less than 90.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Phys exceeded G360 Challenge Samples</fullName>
        <actions>
            <name>X10_Guardant_Challenge_Sample_by_Physician_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Promo_Date_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Total_Promo_Code__c</field>
            <operation>greaterThan</operation>
            <value>10</value>
        </criteriaItems>
        <description>Sent to MA, Mrktg, Sales, CS when a physician exceeded the limit of 10 Guardant Challenge samples</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>RequestAKitEmailOnContact</fullName>
        <actions>
            <name>sendingEmailToCSTeam</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>UncheckRequestAKit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Requestakit__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SL Threshold Date</fullName>
        <actions>
            <name>Fill_SL_Threshold_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Cumulative_Expenses__c</field>
            <operation>greaterOrEqual</operation>
            <value>407</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Send 30 Day Churn Notification %28Sales%29</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Days_Since_Last_Sample__c</field>
            <operation>greaterOrEqual</operation>
            <value>30</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.AE_Notified_Physician_Churned__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Inform_Sales_that_Physician_Has_Churned_30_Days</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>X30Day_Churn_AE_Notification</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Stale Customer %7C%7C Last Sample Date</fullName>
        <actions>
            <name>Autofill_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Checkbox_fill</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Days_Since_Last_Sample__c</field>
            <operation>greaterOrEqual</operation>
            <value>365</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Stale__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Stale_Tester_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Stark Law 1</fullName>
        <actions>
            <name>Send_SL_Email_1</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_SL_Notifier</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Stark_Expense_Percentage__c</field>
            <operation>greaterOrEqual</operation>
            <value>70</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.SL_Contact_Notifier_1__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Stark_Expense_Percentage__c</field>
            <operation>lessThan</operation>
            <value>85</value>
        </criteriaItems>
        <description>Email notification sent to AE, RSD, Finance and Billing team to inform that the contact has reached 70% of the yearly Stark Law limit.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Stark Law 2</fullName>
        <actions>
            <name>Send_SL_Email_2</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_SL_Notifier_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Stark_Expense_Percentage__c</field>
            <operation>greaterOrEqual</operation>
            <value>85</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.SL_Contact_Notifier_2__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Stark_Expense_Percentage__c</field>
            <operation>lessThan</operation>
            <value>90</value>
        </criteriaItems>
        <description>Email notification sent to AE, RSD, Finance and Billing team to inform that the contact has reached 85% of the yearly Stark Law limit.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Stark Law 3</fullName>
        <actions>
            <name>Send_SL_Email_3</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_SL_Notifier_3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Stark_Expense_Percentage__c</field>
            <operation>greaterOrEqual</operation>
            <value>90</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.SL_Contact_Notifier_3__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Email notification sent to AE, RSD, Finance and Billing team to inform that the contact has reached 90% (or higher) of the yearly Stark Law limit.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update %23 of last and previous sample last date</fullName>
        <actions>
            <name>Update_of_last_and_previous_sample_las</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Last_Sample_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Previous_Last_Sample_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>NS: 08/09/18 This workflow captures number of 
days between last and previous last sample date</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Contact AM Owner EMail</fullName>
        <actions>
            <name>Update_Contact_AM_Owner_EMail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK( Account_AM_Owner__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Contact BD Owner EMail</fullName>
        <actions>
            <name>Update_BD_Owner_EMail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(ISBLANK( Account_BD_Owner__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update RDS Email</fullName>
        <actions>
            <name>Update_RDS_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>8/1/2019</value>
        </criteriaItems>
        <description>Contact object</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Contact_was_unqualified_by_CS</fullName>
        <assignedTo>ablair@guardanthealth.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Contact was unqualified by CS</subject>
    </tasks>
    <tasks>
        <fullName>NPI_Number_Changed</fullName>
        <assignedTo>ablair@guardanthealth.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>NPI number for qualified contact has changed; sys admins need to review</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>NPI Number Changed for qualified contact</subject>
    </tasks>
    <tasks>
        <fullName>Physician_has_submitted_their_1st_Guardant_Sample</fullName>
        <assignedToType>owner</assignedToType>
        <description>Hello
This task has been sent to you to inform you that this physician has submitted their first Guardant 360 sample!</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Physician has submitted their 1st Guardant Sample!!</subject>
    </tasks>
</Workflow>
