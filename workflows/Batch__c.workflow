<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Uncheck_Update_Batch_Name</fullName>
        <field>Update_Batch_Name__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Update Batch Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Batch_Label</fullName>
        <description>Called by PB &quot;SOW: Update Batch&quot;</description>
        <field>Batch_Label__c</field>
        <formula>Account_Code__c + &quot;_&quot;+ SOW_Number__c + &quot;_&quot;+ Product_Name__c + &quot;_&quot;+Batch_text__c</formula>
        <name>Update Batch Label</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Batch Name</fullName>
        <actions>
            <name>Uncheck_Update_Batch_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Batch_Label</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Batch__c.Update_Batch_Name__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates Batch Name. Initiated by PB &apos;SOW: Update Batch&apos;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
