<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Opp_Owner_Mgr_Notification</fullName>
        <ccEmails>scollora@guardanthealth.com</ccEmails>
        <description>Opp Owner Mgr Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Opp_Owner_s_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Sales_Email_Templates/Missed_Opportunity_Update_Required</template>
    </alerts>
    <alerts>
        <fullName>Opp_Owner_Mgr_Notification_7_Days</fullName>
        <ccEmails>scollora@guardanthealth.com</ccEmails>
        <description>Opp Owner Mgr Notification - 7 Days</description>
        <protected>false</protected>
        <recipients>
            <field>Opp_Owner_s_Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>sfdc-admin@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Sales_Email_Templates/Missed_Opportunity_Update_Required_7_Days</template>
    </alerts>
    <fieldUpdates>
        <fullName>Auto_Fill_Owner_Mgr_Email_Address</fullName>
        <field>Opp_Owner_s_Manager_Email__c</field>
        <formula>Owner_s_Manager_Email__c</formula>
        <name>Auto Fill Owner Mgr Email Address</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Auto Fill Opp Owner Mgr Email</fullName>
        <actions>
            <name>Auto_Fill_Owner_Mgr_Email_Address</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.CreatedDate</field>
            <operation>greaterThan</operation>
            <value>5/1/2015</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Missed Close Date</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Opportunity_Missed_Close_Date</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Missed Close Date 2</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.IsWon</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Opp_Owner_Mgr_Notification</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Opportunity_Out_of_Date_Update_Required1</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Opportunity_Missed_10_Days</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Opportunity_Out_of_Date_Update_Required</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Opp_Owner_Mgr_Notification_7_Days</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Opportunity_Missed_7_Days</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Opportunity_Closed_Date_in_the_Past</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Opportunity Closed Date in the Past</subject>
    </tasks>
    <tasks>
        <fullName>Opportunity_Closed_Date_in_the_Past_10_Days</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Opportunity Closed Date in the Past, 10 Days</subject>
    </tasks>
    <tasks>
        <fullName>Opportunity_Missed_10_Days</fullName>
        <assignedToType>owner</assignedToType>
        <description>This opportunity&apos;s close date is 10 days old, please take a moment to update this opportunity accordingly.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Opportunity Missed - 10 Days</subject>
    </tasks>
    <tasks>
        <fullName>Opportunity_Missed_7_Days</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Opportunity Missed - 7 Days</subject>
    </tasks>
    <tasks>
        <fullName>Opportunity_Out_of_Date_Update_Required</fullName>
        <assignedToType>owner</assignedToType>
        <description>If opportunity has been won, update status and quantity. 

If opportunity is outstanding, update close date.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Opportunity Out of Date - Update Required</subject>
    </tasks>
    <tasks>
        <fullName>Opportunity_Out_of_Date_Update_Required1</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please review this opportunity and update close date as needed. If opportunity has been won, please update Quantity.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Opportunity Out of Date - Update Required1</subject>
    </tasks>
    <tasks>
        <fullName>Please_update_opportunity</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Please update opportunity</subject>
    </tasks>
    <tasks>
        <fullName>Update_Opportunity_Missed_Close_Date</fullName>
        <assignedToType>owner</assignedToType>
        <description>Please review this opportunity and update close date as needed. If opportunity has been won, please update Quantity.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Update Opportunity - Missed Close Date</subject>
    </tasks>
</Workflow>
