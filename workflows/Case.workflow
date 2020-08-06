<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Case_Account_Qualification_Case_Email_Alert</fullName>
        <ccEmails>ClientServices@guardanthealth.com</ccEmails>
        <description>Case: Account Qualification Case Email Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Client_Services_Email_Templates/New_Account_Qualification_Case</template>
    </alerts>
    <alerts>
        <fullName>Case_Alert_Account_Owner</fullName>
        <description>Case: Alert Account Owner</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Client_Services_Email_Templates/Case_Alert_Account_Owner_Of_Case_Status</template>
    </alerts>
    <alerts>
        <fullName>Case_EMail_alert_sent_to_AE_for_High_Priority_Cases</fullName>
        <description>Case: EMail alert sent to AE for High-Priority Cases</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>clientservices@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Client_Services_Email_Templates/Case_Alert_AE_of_High_Priority</template>
    </alerts>
    <alerts>
        <fullName>Case_Retest_AE_Alert</fullName>
        <description>Case: Retest AE Alert</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderAddress>clientservices@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Client_Services_Email_Templates/Case_Alert_AE_of_Retest_Delay</template>
    </alerts>
    <alerts>
        <fullName>Case_Tracking_Number_Email_Alert</fullName>
        <description>Case: Tracking Number Email Alert</description>
        <protected>false</protected>
        <recipients>
            <field>Ship_To_Contact_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>clientsupport@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Client_Services_Email_Templates/Case_Tracking_Number</template>
    </alerts>
    <alerts>
        <fullName>Inform_Sales_when_Customer_Requests_Supplies</fullName>
        <description>Inform Sales when Customer Requests Supplies</description>
        <protected>false</protected>
        <recipients>
            <field>Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Client_Services_Email_Templates/Customer_Req_Supplies_Inform_Sales</template>
    </alerts>
    <alerts>
        <fullName>Inform_sales_that_customer_reported_an_issue</fullName>
        <description>Inform sales that customer reported an issue</description>
        <protected>false</protected>
        <recipients>
            <field>Account_AE_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Client_Services_Email_Templates/Inform_Sales_Of_Issue_Reported_by_customer</template>
    </alerts>
    <alerts>
        <fullName>Notification_for_Sales_that_a_patient_has_been_contacted_by_CSBA</fullName>
        <description>Notification for Sales that a patient has been contacted by CSBA</description>
        <protected>false</protected>
        <recipients>
            <field>Account_AE_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>clientservices@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/Patient_Contacted_by_CSBA</template>
    </alerts>
    <alerts>
        <fullName>Request_a_Kit_Case_notification</fullName>
        <description>&quot;Request a Kit&quot; Case Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>jupjohn@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/Case_Request_a_Kit</template>
    </alerts>
    <fieldUpdates>
        <fullName>AutoFill_Acct_Email_on_Case</fullName>
        <field>Account_AE_Email__c</field>
        <formula>Acct_AE_Email_Address__c</formula>
        <name>AutoFill Acct Email on Case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Reset_Send_Email_Notification</fullName>
        <field>Send_Email_Notification__c</field>
        <literalValue>0</literalValue>
        <name>Case: Reset Send Email Notification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Set_Due_Date_to_Today</fullName>
        <field>Due_Date__c</field>
        <formula>TODAY()</formula>
        <name>Case: Set Due Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Set_Request_No_to_Case_No</fullName>
        <field>Request_No__c</field>
        <formula>CaseNumber</formula>
        <name>Case: Set Request No to Case No</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Set_Search_Data_1</fullName>
        <field>Search_Data_1__c</field>
        <formula>Account.Name &amp; &apos;, &apos; &amp; Contact.FirstName &amp; &apos; &apos; &amp; Contact.LastName</formula>
        <name>Case: Set Search Data 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Set_TheraPak_Status_To_Delivered</fullName>
        <field>TheraPak_Status__c</field>
        <literalValue>Delivered</literalValue>
        <name>Case: Set TheraPak Status To Delivered</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_owner_to_CSBA_queue</fullName>
        <field>OwnerId</field>
        <lookupValue>CSBA</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Change owner to CSBA queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check_AE_Informed_box</fullName>
        <field>AE_Informed__c</field>
        <literalValue>1</literalValue>
        <name>Check AE Informed box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fill_Accession_Number</fullName>
        <field>Accession_No__c</field>
        <formula>Guardant_360_Sample__r.Name</formula>
        <name>Fill Accession Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fill_Email_Sent_Date</fullName>
        <field>Kit_Supplies_AE_Email_Sent__c</field>
        <formula>TODAY()</formula>
        <name>Fill Email Sent Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_A_number_with_PA_A_number</fullName>
        <description>Updates Accession # with A-Number from PA</description>
        <field>Accession_No__c</field>
        <formula>PA_Associated_with_G360_Test__r.Name</formula>
        <name>Update A number with PA A number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date</fullName>
        <description>Updates Sample Rec&apos;d Date if A# field is not blank</description>
        <field>Sample_Received_Date__c</field>
        <formula>Guardant_360_Sample__r.Date_Received__c</formula>
        <name>Update Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Received</fullName>
        <field>Sample_Received_Date__c</field>
        <formula>Guardant_360_Sample__r.Date_Received__c</formula>
        <name>Update Date Received</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Final_Report_Date</fullName>
        <field>Sample_Final_Report_Date__c</field>
        <formula>Guardant_360_Sample__r.Final_Report_Date__c</formula>
        <name>Update Final Report Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Patient_Name_from_A_Number</fullName>
        <description>Updates Pt Name field</description>
        <field>Pt_Name__c</field>
        <formula>PA_Associated_with_G360_Test__r.Patient__r.Full_Name__c</formula>
        <name>Update Patient Name from A-Number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Pt_First_Name</fullName>
        <field>Pt_First_Name__c</field>
        <formula>PA_Associated_with_G360_Test__r.Patient__r.First_Name__c</formula>
        <name>Update Pt First Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Pt_Last_Name</fullName>
        <field>Pt_Last_Name__c</field>
        <formula>PA_Associated_with_G360_Test__r.Patient__r.Last_Name__c</formula>
        <name>Update Pt Last Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sales_Email_Address</fullName>
        <field>Email__c</field>
        <formula>Account.Owner.Email</formula>
        <name>Update Sales Email Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Accession Number Auto Fill</fullName>
        <actions>
            <name>Fill_Accession_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Auto pop Accession Number (text) with Accession # (lookup) each time a case is created.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Account Qualification Case Email Alert</fullName>
        <actions>
            <name>Case_Account_Qualification_Case_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Client_Services_Email_Alert__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Alert AE of Retest Delay</fullName>
        <actions>
            <name>Case_Retest_AE_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_Alert_Sent_To_Account_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Record_Type_ID__c</field>
            <operation>equals</operation>
            <value>01280000000HmU1</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RETEST_Notify_AE__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Resolved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Account_Owner__c</field>
            <operation>notEqual</operation>
            <value>Daniel Simon</value>
        </criteriaItems>
        <description>Alerts AE of testing delay if second tube had to be retested</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Alert Account Owner</fullName>
        <actions>
            <name>Case_Alert_Account_Owner</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Case_Reset_Send_Email_Notification</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Email_Alert_Sent_To_Account_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Send_Email_Notification__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Alert to AE of High Priority</fullName>
        <actions>
            <name>Case_EMail_alert_sent_to_AE_for_High_Priority_Cases</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_Alert_Sent_To_Account_Owner</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>High</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Inform sales when issue%27s reported by customer</fullName>
        <actions>
            <name>Inform_sales_that_customer_reported_an_issue</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Client Concerns</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Set Request No</fullName>
        <actions>
            <name>Case_Set_Request_No_to_Case_No</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Request_No__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Supplies Case</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Set Rush Order</fullName>
        <actions>
            <name>Case_Set_Due_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Rush_Order__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Set Search Data Fields</fullName>
        <actions>
            <name>Case_Set_Search_Data_1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( AccountId ) || ISCHANGED( ContactId )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case%3A Set TheraPak Status To Delivered</fullName>
        <actions>
            <name>Case_Set_TheraPak_Status_To_Delivered</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>(isnew() = false) &amp;&amp; (ischanged( Supplies_TheraPak_Pending_Count__c ) = true) &amp;&amp;  (Supplies_TheraPak_Pending_Count__c = 0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Inform AE that patient was contacted by CSBA</fullName>
        <actions>
            <name>Notification_for_Sales_that_a_patient_has_been_contacted_by_CSBA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Check_AE_Informed_box</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Patient_contacted__c</field>
            <operation>equals</operation>
            <value>1st</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.AE_Informed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>1/28/2020</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Inform Sales when Kits Requested by Customer</fullName>
        <actions>
            <name>Inform_Sales_when_Customer_Requests_Supplies</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Fill_Email_Sent_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Activity_Type__c</field>
            <operation>equals</operation>
            <value>Kit Supplies</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Account_Owner__c</field>
            <operation>notEqual</operation>
            <value>Daniel Simon</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Kit Request Case Notification</fullName>
        <actions>
            <name>Request_a_Kit_Case_notification</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Subject</field>
            <operation>equals</operation>
            <value>Kit Request Via Website</value>
        </criteriaItems>
        <description>Notify Director of CS when a Case is auto-created via the Request a Kit section of our website.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>PA Follow-Up Reminder</fullName>
        <actions>
            <name>PA_Follow_Up</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>Creates follow-up reminder task for PA case owner based on &apos;Next Follow-Up Date&apos;</description>
        <formula>AND (
RecordType.Id = &apos;012340000007mvo&apos;,
Next_Follow_Up_Date__c =TODAY()
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update AE Address</fullName>
        <actions>
            <name>AutoFill_Acct_Email_on_Case</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>x-Financial Case</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Accession %23</fullName>
        <actions>
            <name>Update_A_number_with_PA_A_number</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Patient_Name_from_A_Number</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Pt_First_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Pt_Last_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates various values if the Accession # associated with PA is not blank</description>
        <formula>OR(
   AND(
   NOT(ISBLANK(PA_Associated_with_G360_Test__c)),
   ISBLANK(PA_Cases__c)),
   NOT(ISBLANK(PA_Cases__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Recd Date</fullName>
        <actions>
            <name>Update_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR( 
NOT(ISBLANK(Guardant_360_Sample__c)),
NOT(ISBLANK(Accession_No__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Sales Email Address</fullName>
        <actions>
            <name>Update_Sales_Email_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Activity_Type__c</field>
            <operation>equals</operation>
            <value>Kit Supplies</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Sample Recd Date</fullName>
        <actions>
            <name>Update_Date_Received</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Final_Report_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Accession_No__c</field>
            <operation>startsWith</operation>
            <value>A</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Email_Alert_Sent_To_Account_Owner</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Email Alert Sent To Account Owner</subject>
    </tasks>
    <tasks>
        <fullName>PA_Follow_Up</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Case.Next_Follow_Up_Date__c</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>PA Follow Up</subject>
    </tasks>
</Workflow>
