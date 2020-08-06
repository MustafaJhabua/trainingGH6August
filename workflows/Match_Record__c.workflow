<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>External_PTC_alert</fullName>
        <ccEmails>referrals@guardanthealth.com</ccEmails>
        <ccEmails>panaburmath@guardanthealth.com</ccEmails>
        <description>External PTC alert</description>
        <protected>false</protected>
        <recipients>
            <field>External_Alert_Email_1__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>External_Alert_Email_2__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>External_Alert_Email_3__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>External_Alert_Email_4__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>referrals@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Pharma_Internal_Alerts/External_Pharma_Permission_to_Connect_V2</template>
    </alerts>
    <alerts>
        <fullName>Match_Pharma_Permission_to_Connect_Email_alert</fullName>
        <description>Match: Pharma Permission to Connect Email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>mkuenzi@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderAddress>ue@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Pharma_Internal_Alerts/Permission_to_Connect</template>
    </alerts>
    <fieldUpdates>
        <fullName>GuardantNotes1</fullName>
        <field>Guardant_Notes_1__c</field>
        <formula>PRIORVALUE(  Guardant_Notes_1__c  )</formula>
        <name>GuardantNotes1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>GuardantNotes2</fullName>
        <description>Updates GuardantNotes 2 field with Prior Value of Guardant Notes 1</description>
        <field>Guardant_Notes_2__c</field>
        <formula>PRIORVALUE( Guardant_Notes_1__c  )</formula>
        <name>GuardantNotes2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MR_Date_Outreach_Email_Read</fullName>
        <description>Updates field &quot;Date Outreach Email Read&quot; with current day when &quot;Outreach Email Read?&quot; checkbox is checked</description>
        <field>Date_Outreach_Email_Read__c</field>
        <formula>TODAY()</formula>
        <name>MR: Date Outreach Email Read</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MR_Date_Replied_to_Outreach_Email</fullName>
        <description>Updates field &quot;Date Replied to Outreach Email&quot; with current day when &quot;Replied to Outreach Email?&quot; checkbox is checked</description>
        <field>Date_Replied_to_Outreach_Email__c</field>
        <formula>TODAY()</formula>
        <name>MR: Date Replied to Outreach Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MR_External_Notes2</fullName>
        <description>Updates field External Notes with values from ExtNote2</description>
        <field>Guardant_Notes__c</field>
        <formula>ExtNote2__c +&quot; &quot;+ PRIORVALUE(  Guardant_Notes__c )</formula>
        <name>MR External Notes2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MR_Internal_Notes2</fullName>
        <description>Updates field Internal Notes with values from IntNote2</description>
        <field>Match_Record_Notes__c</field>
        <formula>IntNote2__c + BR() + PRIORVALUE( Match_Record_Notes__c )</formula>
        <name>MR Internal Notes2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MR_Update_Notes_about_MD</fullName>
        <description>Update field Notes about MD with values from Notes About MD2</description>
        <field>Notes_About_MD__c</field>
        <formula>Notes_About_MD_2__c +  BR() + PRIORVALUE(  Notes_About_MD__c )</formula>
        <name>MR: Update Notes about MD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Match_Record_Date_Referred</fullName>
        <description>Updates Date Referred field when Enrollment status is changed to Enrolled from the Match Record</description>
        <field>Date_Referred__c</field>
        <formula>NOW()</formula>
        <name>Match Record:Date Referred</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Match_Show_to_pharma</fullName>
        <description>Updates Match: Show to Pharma</description>
        <field>Show_to_Pharma__c</field>
        <literalValue>1</literalValue>
        <name>Match: Show to pharma</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Closest_Trial_Site_City</fullName>
        <field>Closest_Trial_Site_City__c</field>
        <formula>Closest_Trial_Site__r.BillingCity</formula>
        <name>Update Closest Trial Site City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Closest_Trial_Site_State</fullName>
        <field>Closest_Trial_Site_State__c</field>
        <formula>Closest_Trial_Site__r.BillingState</formula>
        <name>Update Closest Trial Site State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Replied_to_Last_Ditch_Email</fullName>
        <field>Date_Replied_to_Last_Ditch_Email__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Replied to Last Ditch Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Screened</fullName>
        <description>Updates &apos;Date Screened&apos; field when &apos;Screened?&apos; is checked</description>
        <field>Date_Screened__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Screened</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Referral_Status</fullName>
        <field>Enrollment_Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Update Referral Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Referral_Substatus</fullName>
        <field>Enrollment_Sub_Status__c</field>
        <literalValue>Provider Refusal</literalValue>
        <name>Update Referral Substatus</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Substatus_Reason</fullName>
        <field>Sub_Status_Reason__c</field>
        <literalValue>Do Not Contact</literalValue>
        <name>Update Substatus Reason</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>MR%3A Update %27Date Replied to Last Ditch Email</fullName>
        <actions>
            <name>Update_Date_Replied_to_Last_Ditch_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Match_Record__c.Replied_to_Last_Ditch_Email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Match_Record__c.Date_Replied_to_Last_Ditch_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates &apos;Date Replied to Last Ditch Email&apos; field when &apos;Replied to Last Ditch Email?&apos; is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>MR%3A Update %27Date Screened%27</fullName>
        <actions>
            <name>Update_Date_Screened</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Match_Record__c.Screened__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Match_Record__c.Date_Screened__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates &apos;Date Screened&apos; field when &apos;Screened?&apos; is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Match%3A Permission to Connect with Pharma</fullName>
        <actions>
            <name>Match_Pharma_Permission_to_Connect_Email_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Match_Record__c.Permission_to_Connect_with_Pharma__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When &apos;Permission to Connect with Pharma&apos; is checked, fires off email alert to Biopharma Team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Match%3A Update Date Referred</fullName>
        <actions>
            <name>Match_Record_Date_Referred</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Match_Record__c.Enrollment_Status__c</field>
            <operation>equals</operation>
            <value>Referred</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>contains</operation>
            <value>BioPharma</value>
        </criteriaItems>
        <criteriaItems>
            <field>Match_Record__c.Date_Referred__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates Date Referred field when Enrollment changes to Referred</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Match%3A Update Date Referred2</fullName>
        <actions>
            <name>Match_Record_Date_Referred</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Match_Record__c.Referral_Letter_Sent__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>contains</operation>
            <value>BioPharma</value>
        </criteriaItems>
        <description>Updates Date Referred field when &apos;Referral Letter Sent?&apos; is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Match%3A Update Guardant Notes 2</fullName>
        <actions>
            <name>GuardantNotes1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>GuardantNotes2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates field Guardant Notes 2 with prior value of Guardant Notes 1</description>
        <formula>Guardant_Notes_1__c  &lt;&gt;  Guardant_Notes__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Closest Trial Site Fields</fullName>
        <actions>
            <name>Update_Closest_Trial_Site_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Closest_Trial_Site_State</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Closest Trial Site City and State when Closest Trial Site is populated</description>
        <formula>AND(NOT(ISBLANK(Closest_Trial_Site__c)),ISCHANGED(Closest_Trial_Site__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update ExtNote2</fullName>
        <actions>
            <name>MR_External_Notes2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update field External Notes with values from ExtNote2</description>
        <formula>ISCHANGED( ExtNote2__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update IntNote2</fullName>
        <actions>
            <name>MR_Internal_Notes2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update field Internal Notes with values from IntNote2</description>
        <formula>ISCHANGED( IntNote2__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update MR%3A Date Outreach Email Read</fullName>
        <actions>
            <name>MR_Date_Outreach_Email_Read</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Match_Record__c.Outreach_Email_Read__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Match_Record__c.Date_Outreach_Email_Read__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates &apos;Date Outreach Email Read&apos; when corresponding checkbox is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update MR%3A Date Replied to Outreach Email</fullName>
        <actions>
            <name>MR_Date_Replied_to_Outreach_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Match_Record__c.Replied_to_Outreach_Email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Match_Record__c.Date_Replied_to_Outreach_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Updates &apos;Date Replied to Outreach Email&apos; when corresponding checkbox is checked</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Notes About MD</fullName>
        <actions>
            <name>MR_Update_Notes_about_MD</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates Notes About MD field with values from Notes About MD2</description>
        <formula>ISCHANGED( Notes_About_MD_2__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Status when Do Not Contact override is unchecked</fullName>
        <actions>
            <name>Update_Referral_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Referral_Substatus</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Substatus_Reason</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Match_Record__c.DO_NOT_CONTACT__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Match_Record__c.Do_Not_Contact_Override__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>When &apos;Do Not Contact Override&apos; goes from checked to unchecked, and &apos;Do Not Contact&apos; is checked, this resets the Referral Status/Substatus/Reason fields to &apos;Closed/Provider Refusal/Do Not Contact&apos;. ENT-9323</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
