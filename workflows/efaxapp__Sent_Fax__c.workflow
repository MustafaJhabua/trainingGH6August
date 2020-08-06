<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>efaxapp__Send_Fax_Attachment</fullName>
        <apiVersion>33.0</apiVersion>
        <endpointUrl>https://fax.ramseysolutions.com/efax/v2/outboundsend</endpointUrl>
        <fields>Id</fields>
        <fields>efaxapp__Attachment_ID__c</fields>
        <fields>efaxapp__Barcode_Position_Left__c</fields>
        <fields>efaxapp__Barcode_Position_Top__c</fields>
        <fields>efaxapp__Barcode_Size_Width__c</fields>
        <fields>efaxapp__Fax_Number__c</fields>
        <fields>efaxapp__Org_Fax_Number__c</fields>
        <fields>efaxapp__Subject__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>rsmith@guardanthealth.com</integrationUser>
        <name>Send Fax Attachment</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>efaxapp__Send_Fax_Attachment</fullName>
        <actions>
            <name>efaxapp__Send_Fax_Attachment</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>efaxapp__Sent_Fax__c.efaxapp__Sent_With_Outbound_Message__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
