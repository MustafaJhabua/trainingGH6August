<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Email</fullName>
        <description>Updates Email values with corresponding values from the Hidden Email</description>
        <field>Email__c</field>
        <formula>Hidden_Email__c</formula>
        <name>Update Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Fax</fullName>
        <description>Updates Fax field with value in Hidden Fax field</description>
        <field>Fax__c</field>
        <formula>Hidden_Fax__c</formula>
        <name>Update Fax</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Phone</fullName>
        <description>Updates Phone with value in Hidden Phone field</description>
        <field>Phone__c</field>
        <formula>Hidden_Phone__c</formula>
        <name>Update Phone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Trial Site Contact%3A Update Email</fullName>
        <actions>
            <name>Update_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Email values with corresponding values from the Hidden Email</description>
        <formula>AND ( 
NOT(ISBLANK(Hidden_Email__c)), 
ISBLANK( Email__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Trial Site Contact%3A Update fax</fullName>
        <actions>
            <name>Update_Fax</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Fax values with corresponding values from the Hidden Fax field</description>
        <formula>AND ( 
NOT(ISBLANK(Hidden_Fax__c)), 
ISBLANK( Fax__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Trial Site Contact%3A Update phone</fullName>
        <actions>
            <name>Update_Phone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Phone values with corresponding values from the Hidden Phone</description>
        <formula>AND ( 
NOT(ISBLANK(Hidden_Phone__c)), 
ISBLANK( Phone__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
