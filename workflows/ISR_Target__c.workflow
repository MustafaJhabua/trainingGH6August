<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Call_Notes</fullName>
        <description>Updates Call Notes field</description>
        <field>Call_Notes__c</field>
        <formula>$User.Initials__c+&quot; &quot;+ TEXT(MONTH(TODAY())) + &quot;/&quot; + TEXT(DAY(TODAY())) + &quot;/&quot; + TEXT(YEAR(TODAY())) + &quot;: &quot; + Note_Entry__c + BR() + PRIORVALUE(Call_Notes__c)</formula>
        <name>Update Call Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Call Notes</fullName>
        <actions>
            <name>Update_Call_Notes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Call Notes with date/user initials/notes from ISR tasks</description>
        <formula>ISCHANGED(Note_Entry__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
