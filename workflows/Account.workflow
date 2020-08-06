<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account_Reparenting_Notification</fullName>
        <description>Account: Reparenting Notification</description>
        <protected>false</protected>
        <recipients>
            <field>RSD_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <recipient>khallam@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/Account_has_been_reparented_by_AE</template>
    </alerts>
    <alerts>
        <fullName>Email_system_administrator_when_the_payor_account_contains_DNU</fullName>
        <description>Email system administrator when the payor account contains DNU</description>
        <protected>false</protected>
        <recipients>
            <recipient>ablair@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Email_to_Ruben_when_payor_account_is_DNU</template>
    </alerts>
    <alerts>
        <fullName>Notify_DL_SEC_contract_is_active</fullName>
        <ccEmails>EnterpriseSales@GuardantHealth.com</ccEmails>
        <description>Notify DL SEC contract is active</description>
        <protected>false</protected>
        <recipients>
            <recipient>ddouglas@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/SEC_Signed_Notify</template>
    </alerts>
    <alerts>
        <fullName>Notify_DL_SEC_contract_is_terminated</fullName>
        <ccEmails>EnterpriseSales@GuardantHealth.com</ccEmails>
        <description>Notify DL SEC contract is terminated</description>
        <protected>false</protected>
        <recipients>
            <recipient>ddouglas@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/SEC_Terminated_Notify</template>
    </alerts>
    <fieldUpdates>
        <fullName>Account_Set_Push_To_Netsuite_Date</fullName>
        <field>Push_To_NetSuite_Date__c</field>
        <formula>TODAY()</formula>
        <name>Account: Set Push To Netsuite Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Set_Push_to_TheraPak_Date</fullName>
        <field>Push_To_TheraPak_Date__c</field>
        <formula>NOW()</formula>
        <name>Account: Set Push to TheraPak Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Set_Sample_Alert</fullName>
        <field>Sample_Alert_21_Days__c</field>
        <literalValue>1</literalValue>
        <name>Account: Set Sample Alert</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Set_TheraPak_Status_to_Pending</fullName>
        <field>TheraPak_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Account: Set TheraPak Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Account_Uncheck_Push_to_TheraPak</fullName>
        <field>Push_To_TheraPak__c</field>
        <literalValue>0</literalValue>
        <name>Account: Uncheck Push to TheraPak</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Fill_MSL_Email</fullName>
        <field>MSL_Email__c</field>
        <formula>Account_MSL__r.Email</formula>
        <name>Auto Fill MSL Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Fill_Pharma_Portal_Date</fullName>
        <field>Pharma_Portal_Account_Creation_Date__c</field>
        <formula>TODAY()</formula>
        <name>Auto Fill Pharma Portal Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Prospect_to_Customer</fullName>
        <description>Occurs when the Account has submitted 1 or more samples.</description>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <name>Change Prospect to Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fill_Address_Change_Date</fullName>
        <field>Date_Address_Last_Changed__c</field>
        <formula>Today()</formula>
        <name>Fill Address Change Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Portal_Checkbox</fullName>
        <field>Portal_Site__c</field>
        <literalValue>0</literalValue>
        <name>Portal Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Field_to_Push_Netsuite_update</fullName>
        <field>Push_To_NetSuite_Date__c</field>
        <formula>today()</formula>
        <name>Set Push to Netsuite update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_AM_Owner_Email</fullName>
        <field>AM_Owners_Email__c</field>
        <formula>CASE(TEXT(AM_Owner_list__c), 
&apos;Jeshaune Jackson&apos;, &apos;jjackson@guardanthealth.com&apos;, 
&apos;Manasa Chandra&apos;, &apos;mchandra@guardanthealth.com&apos;, 
&apos;Shantanu Mittal&apos;, &apos;smittal@guardanthealth.com&apos;,
&apos;Ali Mukherjee&apos;, &apos;amukherjee@guardanthealth.com&apos;, 
&apos;Alexander Kuklin&apos;, &apos;akuklin@guardanthealth.com&apos;,
&apos;&apos; )</formula>
        <name>Update AM Owner Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Account_Status</fullName>
        <field>Type</field>
        <literalValue>Customer</literalValue>
        <name>Update Account Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_City</fullName>
        <field>BillingCity</field>
        <formula>&quot;Redwood City&quot;</formula>
        <name>Update Address City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_Country</fullName>
        <field>BillingCountry</field>
        <formula>&quot;US&quot;</formula>
        <name>Update Address Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_State</fullName>
        <field>BillingState</field>
        <formula>&quot;CA&quot;</formula>
        <name>Update Address State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_Street</fullName>
        <field>BillingStreet</field>
        <formula>&quot;123 Main St&quot;</formula>
        <name>Update Address Stret</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Address_Zip</fullName>
        <field>BillingPostalCode</field>
        <formula>&quot;94063&quot;</formula>
        <name>Update Address Zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_BD_Owner_EMail</fullName>
        <field>BD_Owners_Email__c</field>
        <formula>CASE(TEXT(BD_Owner_list__c), 
&apos;Alexandra Franovic&apos;, &apos;afranovic@guardanthealth.com&apos;, 
&apos;Brenton Foretich&apos;, &apos;bforetich@guardanthealth.com&apos;, 
&apos;Chris Dankulich&apos;, &apos;cdankulich@guardanthealth.com&apos;, 
&apos;Daniel Simon&apos;, &apos;dsimon@guardanthealth.com&apos;, 
&apos;Dhiren Belur&apos;, &apos;dbelur@guardanthealth.com&apos;, 
&apos;Jeshaune Jackson&apos;, &apos;jjackson@guardanthealth.com&apos;, 
&apos;Nick Sloman&apos;, &apos;nsloman@guardanthealth.com&apos;, 
&apos;Kapil Jain&apos;, &apos;kjain@guardanthealth.com&apos;, 
&apos;Manasa Chandra&apos;, &apos;mchandra@guardanthealth.com&apos;, 
&apos;Maxim Schillebeeckx&apos;, &apos;mschillebeeckx@guardanthealth.com&apos;, 
&apos;Melissa Gebhardt&apos;, &apos;mgebhardt@guardanthealth.com&apos;, 
&apos;Nnamdi Ihuegbu&apos;, &apos;nihuegbu@guardanthealth.com&apos;, 
&apos;Shantanu Mittal&apos;, &apos;smittal@guardanthealth.com&apos;, 
&apos;Peter Collins&apos;, &apos;pcollins@guardanthealth.com&apos;,
&apos;Aparna Upadhyay&apos;, &apos;aupadhyay@guardanthealth.com&apos;,
&apos;&apos; )</formula>
        <name>Update BD Owner EMail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Fellowship</fullName>
        <field>Fellowship_Account__c</field>
        <literalValue>1</literalValue>
        <name>Update Fellowship</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Reporting_Country</fullName>
        <description>Updates Reporting Country to &quot;US&quot;</description>
        <field>BillingCountry</field>
        <formula>&quot;US&quot;</formula>
        <name>Update Reporting Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_SEC_Active_Notification_Date</fullName>
        <field>SEC_Active_Notification_Date__c</field>
        <formula>TODAY()</formula>
        <name>Update SEC Active Notification Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_SEC_Terminated_Notification_Date</fullName>
        <field>SEC_Termination_Notification_Date__c</field>
        <formula>Today()</formula>
        <name>Update SEC Terminated Notification Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Account%3A Last Sample Date Was 21 Days Ago</fullName>
        <active>true</active>
        <formula>Sample_Alert_21_Days__c = True &amp;&amp;
 Last_Sample_Date__c  = Today()-21</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Last_Sample_Date_21_Days_Ago</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Account.Last_Sample_Date__c</offsetFromField>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Account%3A Pharma Portal Account field</fullName>
        <actions>
            <name>Portal_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Pharma Site,Pharma Company</value>
        </criteriaItems>
        <description>Pharma Portal Account field should be checked by default for every Pharma record type. AB 3/11/2020- Obsolete, not required</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Account%3A Push Netsuite Date</fullName>
        <actions>
            <name>Account_Set_Push_To_Netsuite_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Push_to_NetSuite__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>AB 3/11/2020- Obsolete, Netsuite is no longer used at GHI</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Account%3A Push to TheraPak</fullName>
        <actions>
            <name>Account_Set_Push_to_TheraPak_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Account_Set_TheraPak_Status_to_Pending</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Account_Uncheck_Push_to_TheraPak</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Push_To_TheraPak__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Account%3A Set Sample Alert</fullName>
        <actions>
            <name>Account_Set_Sample_Alert</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>$Setup.Workflow_Control__c.Enable_Workflow_Rule__c &amp;&amp; NOT(ISBLANK( Last_Sample_Date__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Address Change</fullName>
        <actions>
            <name>Fill_Address_Change_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Date captured when address is changed in Account record. AB 3/11/2020- Obsolete, superseded by Process &quot;Account: Update Date Address/Record Last Changed&quot;</description>
        <formula>ISCHANGED (BillingStreet) ||
ISCHANGED (BillingCity) ||
ISCHANGED (BillingState) ||
ISCHANGED (BillingCountry) ||
ISCHANGED (BillingPostalCode) ||
ISCHANGED (ShippingStreet) ||
ISCHANGED (ShippingCity) ||
ISCHANGED (ShippingState) ||
ISCHANGED (ShippingCountry) ||
ISCHANGED (ShippingPostalCode) ||
ISCHANGED (Phone) ||
ISCHANGED (Fax) ||
ISCHANGED (Name)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Insurance Acct Address Update</fullName>
        <actions>
            <name>Update_Address_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Address_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Address_State</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Address_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Address_Zip</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Insurance</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.BillingState</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>MSL Default to MATasks</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Account.Account_Type__c</field>
            <operation>equals</operation>
            <value>Clinical Account US</value>
        </criteriaItems>
        <description>When a Clinical Account US (Commercial) is created, we will default the value to MedAffairs Task user. AB 3/11/2020- Obsolete, never used</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify Active SEC</fullName>
        <actions>
            <name>Notify_DL_SEC_contract_is_active</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_SEC_Active_Notification_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Contract__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SEC_Active_Notification_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>SEC = Sales Enterprise Contract</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify Terminated SEC</fullName>
        <actions>
            <name>Notify_DL_SEC_contract_is_terminated</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_SEC_Terminated_Notification_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Contract__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Status__c</field>
            <operation>equals</operation>
            <value>Terminated</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.SEC_Termination_Notification_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Payor Account Address Update</fullName>
        <actions>
            <name>Update_Reporting_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.RecordTypeId</field>
            <operation>equals</operation>
            <value>Payor Account</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Account_Type__c</field>
            <operation>equals</operation>
            <value>Payor</value>
        </criteriaItems>
        <description>Defaults all Payor accounts to have billing country = &quot;US&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Pharma Portal Account Date</fullName>
        <actions>
            <name>Auto_Fill_Pharma_Portal_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Created_for_Pharma_Portal__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Pharma_Portal_Account_Creation_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Fill Pharma Portal Account Creation Date (Today) when Created for Pharma Portal is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Prospect to Customer</fullName>
        <actions>
            <name>Change_Prospect_to_Customer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Account_Type__c</field>
            <operation>equals</operation>
            <value>Clinical Account US</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Number_of_Samples__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Push to NetSuite Date Update</fullName>
        <actions>
            <name>Set_Field_to_Push_Netsuite_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Push_to_NetSuite__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>AB 3/11/2020- Obsolete, Netsuite is no longer used at GHI</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Rule 1 - Account Qualified Must have a Billing Country</fullName>
        <actions>
            <name>Rule_1_Violated</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.Qualified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.BillingCountry</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>AB 3/11/2020- Obsolete, superseded by validation rule</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update AM Owner Email</fullName>
        <actions>
            <name>Update_AM_Owner_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(ISBLANK(AM_Owner__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update BD Owner Email</fullName>
        <actions>
            <name>Update_BD_Owner_EMail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>NOT(ISBLANK( BD_Owner__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Last_Sample_Date_21_Days_Ago</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Last Sample Date 21 Days Ago</subject>
    </tasks>
    <tasks>
        <fullName>Rule_1_Violated</fullName>
        <assignedTo>ablair@guardanthealth.com</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Rule 1 - Violated</subject>
    </tasks>
</Workflow>
