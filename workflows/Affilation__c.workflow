<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Affiliation_Set_Account_Search_Field</fullName>
        <field>Account_Search__c</field>
        <formula>Account__r.Name</formula>
        <name>Affiliation: Set Account Search Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Affiliation_Set_Contact_Search_Field</fullName>
        <field>Contact_Search__c</field>
        <formula>Contact__r.Full_Name__c</formula>
        <name>Affiliation: Set Contact Search Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_NY_Sample</fullName>
        <field>NY_Sample__c</field>
        <literalValue>1</literalValue>
        <name>Update NY Sample</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Affiliation%3A Set Account Search Field</fullName>
        <actions>
            <name>Affiliation_Set_Account_Search_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE=TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Affiliation%3A Set Contact Search Field</fullName>
        <actions>
            <name>Affiliation_Set_Contact_Search_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE=TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>NY Sample Check</fullName>
        <actions>
            <name>Update_NY_Sample</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.BillingState</field>
            <operation>equals</operation>
            <value>NY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Affilation__c.NY_Sample__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Update NY Sample</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
