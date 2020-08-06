<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Compliance_Team_Last_Year_Stark_Limit_Exceeded</fullName>
        <ccEmails>gshaver@guardanthealth.com</ccEmails>
        <description>Notify Compliance Team || Last Year Stark Limit Exceeded</description>
        <protected>false</protected>
        <recipients>
            <recipient>System_Administrator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>mmccoy@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>scollora@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Stark_Law_Alerts/Previous_Year_Stark_Exceeded</template>
    </alerts>
    <alerts>
        <fullName>Notify_Compliance_Team_Last_Year_Stark_Limit_Reversed</fullName>
        <ccEmails>gshaver@guardanthealth.com</ccEmails>
        <description>Notify Compliance Team || Last Year Stark Limit Reversed</description>
        <protected>false</protected>
        <recipients>
            <recipient>System_Administrator</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>mmccoy@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>scollora@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Stark_Law_Alerts/Previous_Year_Stark_Limit_Reversed</template>
    </alerts>
    <fieldUpdates>
        <fullName>NPI_Record_Name_Update</fullName>
        <description>Updates the record name to the NPI to prevent duplicates.</description>
        <field>Name</field>
        <formula>NPI_Number__c</formula>
        <name>NPI Record Name Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>NPI %23 Update</fullName>
        <actions>
            <name>NPI_Record_Name_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
