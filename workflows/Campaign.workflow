<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Add_Campaign_End_Date</fullName>
        <field>EndDate</field>
        <formula>StartDate</formula>
        <name>Add Campaign End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Campaign_Status</fullName>
        <field>Status</field>
        <literalValue>Completed</literalValue>
        <name>Change Campaign Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Status Change After Event Date</fullName>
        <actions>
            <name>Add_Campaign_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Change_Campaign_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Campaign.CreatedDate</field>
            <operation>greaterOrEqual</operation>
            <value>4/20/2015</value>
        </criteriaItems>
        <description>Once campaign event date has passed, change the campaign status</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
