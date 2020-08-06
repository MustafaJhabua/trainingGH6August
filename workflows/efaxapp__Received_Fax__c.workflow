<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>efaxapp__Received_Fax_Notification_Email_Alert</fullName>
        <description>Received Fax Notification Email Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>efaxapp__eFax_App_Email_Templates/efaxapp__Received_Fax_Notification_Email_Template</template>
    </alerts>
    <rules>
        <fullName>efaxapp__Received Fax Notification</fullName>
        <actions>
            <name>efaxapp__Received_Fax_Notification_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>NOT( ISBLANK ( efaxapp__Fax_URL__c ) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
