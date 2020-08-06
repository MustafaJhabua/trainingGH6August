<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Site_name</fullName>
        <field>Name</field>
        <formula>LEFT(Account_Name__c, 66) + &quot; (&quot; + Site_No__c + &quot;)&quot;</formula>
        <name>Trial Site name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_site_name</fullName>
        <field>Account_Name__c</field>
        <formula>Site__r.Name</formula>
        <name>update site name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>trial site</fullName>
        <actions>
            <name>Site_name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>update_site_name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Study_Site__c.update__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
