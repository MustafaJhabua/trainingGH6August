<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Inform_AE_that_OPS_was_requested_by_their_physician</fullName>
        <description>Inform AE that OPS was requested by their physician.</description>
        <protected>false</protected>
        <recipients>
            <field>Account_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/OPS_Request</template>
    </alerts>
    <fieldUpdates>
        <fullName>Auto_Fill_Ops_AE_Email</fullName>
        <field>Account_Owner_Email__c</field>
        <formula>AE_Email__c</formula>
        <name>Auto Fill Ops AE Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_AE_Notification_Box</fullName>
        <field>AE_Informed__c</field>
        <literalValue>1</literalValue>
        <name>Update AE Notification Box</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Phleb_checkbox</fullName>
        <field>Phleb_Assigned__c</field>
        <literalValue>1</literalValue>
        <name>Update Phleb checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Autofill OPS AE Email</fullName>
        <actions>
            <name>Auto_Fill_Ops_AE_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Offsite_Phlebotomy_Service__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>4/20/2016</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Inform AE that OPS was requested</fullName>
        <actions>
            <name>Inform_AE_that_OPS_was_requested_by_their_physician</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_AE_Notification_Box</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Offsite_Phlebotomy_Service__c.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>10/20/2019</value>
        </criteriaItems>
        <criteriaItems>
            <field>Offsite_Phlebotomy_Service__c.Account_Owner_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Offsite_Phlebotomy_Service__c.AE_Informed__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Phleb Assignement</fullName>
        <actions>
            <name>Update_Phleb_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Offsite_Phlebotomy_Service__c.Phleb_Assignment__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>If Requesting MD is selected for an OPS record, the checkbox will be marked true.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
