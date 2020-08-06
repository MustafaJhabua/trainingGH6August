<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>MedAffairs_new_task_email_to_DL</fullName>
        <description>MedAffairs new task email to DL</description>
        <protected>false</protected>
        <recipients>
            <recipient>matasks@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/MedAffairs_Task_Email</template>
    </alerts>
    <alerts>
        <fullName>Task_Email_to_AE_when_Med_Affairs_task_created_for_their_account_is_completed</fullName>
        <description>Task: Email to AE when Med Affairs task created for their account is completed</description>
        <protected>false</protected>
        <recipients>
            <field>AE_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>medicalaffairs@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/Notify_Sales_when_MedAffairs_task_is_complete</template>
    </alerts>
    <alerts>
        <fullName>Task_Pharma_Permission_To_Connect</fullName>
        <description>Task: Pharma Permission To Connect</description>
        <protected>false</protected>
        <recipients>
            <recipient>afong@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mgebhardt@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mschillebeeckx@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>nfuentes@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>ue@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Pharma_Internal_Alerts/Permission_to_Connect</template>
    </alerts>
    <alerts>
        <fullName>Task_Send_email_to_Account_Owner_when_Med_Affairs_task_is_completed</fullName>
        <description>Task: Send email to Account Owner when Med Affairs task is completed</description>
        <protected>false</protected>
        <recipients>
            <field>AE_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>medicalaffairs@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/Notify_Sales_when_MedAffairs_task_is_complete</template>
    </alerts>
    <alerts>
        <fullName>Task_Send_email_to_Contact_Owner_when_Med_Affairs_task_is_completed</fullName>
        <description>Task: Send email to Contact Owner when Med Affairs task is completed</description>
        <protected>false</protected>
        <recipients>
            <type>campaignMemberDerivedOwner</type>
        </recipients>
        <senderAddress>medicalaffairs@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Workflow_Templates/Notify_Sales_when_MedAffairs_task_is_complete</template>
    </alerts>
    <fieldUpdates>
        <fullName>Concierge_checkbox</fullName>
        <description>Checkbox for Concierge Follow-Up activity</description>
        <field>Concierge_activity__c</field>
        <literalValue>1</literalValue>
        <name>Concierge checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Task_Subject</fullName>
        <description>Copies value of Task_subject into Subject field</description>
        <field>Subject</field>
        <formula>TEXT( Task_Subject__c)</formula>
        <name>Copy Task Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Task_1st_assigned</fullName>
        <description>Records user who was first assigned a task</description>
        <field>X1st_assigned__c</field>
        <formula>Owner:User.Username</formula>
        <name>Task: 1st assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Task_Med_Affairs_Follow_up</fullName>
        <description>Updates &apos;Create a Follow-Up task for Med Affairs?&apos; checkbox when &apos;M/A Follow Up&apos; is checked. Used on Mobile Layouts</description>
        <field>Create_a_follow_up_task_for_Med_Affairs__c</field>
        <literalValue>1</literalValue>
        <name>Task: Med Affairs Follow up</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Task_Set_Subject_to_Task_Subject</fullName>
        <field>Subject</field>
        <formula>TEXT( Task_Subject__c )</formula>
        <name>Task: Set Subject to Task Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Task_medaffairs_checkbox</fullName>
        <description>Checks hidden checkbox when task is assigned to user Medaffairs Tasks or anyone in Med Affairs</description>
        <field>Medaffairs_task__c</field>
        <literalValue>1</literalValue>
        <name>Task: medaffairs checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_POD_checkbox</fullName>
        <description>Updates POD checkbox on Activity to True when activity of record type Email Attachment is created</description>
        <field>POD__c</field>
        <literalValue>1</literalValue>
        <name>Update POD checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Activity%3A Concierge Record Type</fullName>
        <actions>
            <name>Concierge_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.RecordTypeId</field>
            <operation>equals</operation>
            <value>Concierge Follow Up</value>
        </criteriaItems>
        <description>Checks if record type is Concierge Follow-up</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Activity%3A Medaffairs task</fullName>
        <actions>
            <name>Task_medaffairs_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>2 AND 4 and (1 or 3)</booleanFilter>
        <criteriaItems>
            <field>Task.OwnerId</field>
            <operation>equals</operation>
            <value>MedAffairs Tasks,Lesli Kiedrowski,Becky Nagy,Ashley Wells,Thereasa Rich,Victoria Raymond,Kristin Price,Christian Klosowski,Sara Wienke,Nassim Taherian,Christine Lee,Caroline Weipert</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Courtesy Call Type</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.OwnerId</field>
            <operation>equals</operation>
            <value>Erin Borchardt,Kristin Edwards,Pauline Fontaine,Kelsey Johnson,Krysten Shipley,Megan Mckenna,Brianna Volz,Leylah Drusbosky</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>notContain</operation>
            <value>Pardot</value>
        </criteriaItems>
        <description>Hidden checkbox is checked when task is assigned to user &apos;Medaffairs Tasks&apos; or anyone in Med Affairs</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Subject equals Task Subject</fullName>
        <actions>
            <name>Copy_Task_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Task.RecordTypeId</field>
            <operation>equals</operation>
            <value>Call Reporting</value>
        </criteriaItems>
        <description>Subject is same as task subject</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Task%3A Create F%2FU task Mobile</fullName>
        <actions>
            <name>Task_Med_Affairs_Follow_up</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.M_A_Follow_Up__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Used for smaller label on mobile app</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task%3A First Assigned</fullName>
        <actions>
            <name>Task_1st_assigned</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4</booleanFilter>
        <criteriaItems>
            <field>Task.Medaffairs_task__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.OwnerId</field>
            <operation>equals</operation>
            <value>matasks@guardanthealth.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>contains</operation>
            <value>Client Services</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>contains</operation>
            <value>Sales</value>
        </criteriaItems>
        <description>Records whomever the task was first assigned to</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Task%3A Set Subject to Task Subject</fullName>
        <actions>
            <name>Task_Set_Subject_to_Task_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If picklist field Task Subject is not blank, it will overwrite field Subject</description>
        <formula>NOT(ISBLANK(TEXT(Task_Subject__c))) 
&amp;&amp; (Subject &lt;&gt; TEXT(Task_Subject__c))
&amp;&amp; RecordType.Name =&apos;Call Reporting&apos;
&amp;&amp; OwnerId&lt;&gt; &apos;0053400000AtVc1&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update POD checkbox</fullName>
        <actions>
            <name>Update_POD_checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>When Power Tools/Email Attachments button fires on Match or Contact, it creates an activity of record type &quot;Email Attachment&quot;. This rule automatically checks that box when it&apos;s created.</description>
        <formula>RecordTypeId  = &apos;012340000007miG&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
