<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Exhibitor_Event_Approval</fullName>
        <ccEmails>mpowers@guardanthealth.com</ccEmails>
        <ccEmails>nmansour@guardanthealth.com</ccEmails>
        <description>Exhibitor Event Approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KOL_Exhibitor_Event_Approval_Process/Exhibitor_Event_Approved</template>
    </alerts>
    <alerts>
        <fullName>Exhibitor_Event_Rejected</fullName>
        <description>Exhibitor Event Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KOL_Exhibitor_Event_Approval_Process/Exhibit_Event_Request_Reject</template>
    </alerts>
    <alerts>
        <fullName>KOL_Event_Approval</fullName>
        <description>KOL Event Approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mpowers@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>nmansour@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KOL_Exhibitor_Event_Approval_Process/New_KOL_Event_Approval</template>
    </alerts>
    <alerts>
        <fullName>KOL_Speaker_Event_Rejected</fullName>
        <description>KOL Speaker Event Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>KOL_Exhibitor_Event_Approval_Process/KOL_Speaker_Event_Request_Reject</template>
    </alerts>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Fill_Exhibit_Form_Name</fullName>
        <field>Name</field>
        <formula>(Event_Name__c) &amp; &quot;, &quot; &amp; (Event_Location__c)</formula>
        <name>Auto Fill Exhibit Form Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Auto_Fill_Form_Name</fullName>
        <field>Name</field>
        <formula>( Speaker_Name__c ) &amp; &quot; - &quot; &amp; (Event_Location__c)</formula>
        <name>Auto Fill Form Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recall_Submission</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Recall Submission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <name>Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_RSD</fullName>
        <field>RSD__c</field>
        <lookupValue>scollora@guardanthealth.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Set RSD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submit</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Submit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_budget</fullName>
        <field>Budget__c</field>
        <formula>(Number_of_Attendees__c) * 100</formula>
        <name>Update budget</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Auto Fill Exhibit Form Name</fullName>
        <actions>
            <name>Auto_Fill_Exhibit_Form_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Form__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Exhibitor Event Request Form</value>
        </criteriaItems>
        <description>Auto fill form name w/Event Name and Location</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Auto Fill Form Name</fullName>
        <actions>
            <name>Auto_Fill_Form_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Form__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Speaker Function Request Form</value>
        </criteriaItems>
        <description>Auto fill form name w/Speaker Name and Date</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Auto fill budget</fullName>
        <actions>
            <name>Update_budget</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Form__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Speaker Function Request Form</value>
        </criteriaItems>
        <criteriaItems>
            <field>Form__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>11/10/2016</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Reminder Notice for Event Payment</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Form__c.Event_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Form__c.Amount_Paid_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Once the sales event has taken place, notification will be sent to ensure payment is scheduled.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Submit Payment Request</fullName>
        <actions>
            <name>Accounts_Payable_Submit_for_payment</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Form__c.Approval_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Form__c.Event_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Once event has passed, submit/request details for payment.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Accounts_Payable_Submit_for_payment</fullName>
        <assignedTo>ablair@guardanthealth.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Please gather all documentation and submit request to AP for payment. 

If KOL Event, then request expenses and honorarium. 

If Exhibit Event, then submit invoice.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Accounts Payable || Submit for payment</subject>
    </tasks>
</Workflow>
