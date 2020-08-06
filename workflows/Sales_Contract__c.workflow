<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_DL_SEC_is_Active</fullName>
        <ccEmails>EnterpriseSales@GuardantHealth.com</ccEmails>
        <description>Notify DL SEC is Active</description>
        <protected>false</protected>
        <recipients>
            <recipient>ddouglas@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/SEC_Signed_Notify</template>
    </alerts>
    <alerts>
        <fullName>Notify_DL_SEC_is_Terminated</fullName>
        <ccEmails>EnterpriseSales@GuardantHealth.com</ccEmails>
        <description>Notify DL SEC is Terminated</description>
        <protected>false</protected>
        <recipients>
            <recipient>ddouglas@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/SEC_Terminated_Notify</template>
    </alerts>
    <alerts>
        <fullName>Sales_Contract_ASP_Change_Alert</fullName>
        <ccEmails>DL-SalesContracts@guardanthealth.com</ccEmails>
        <description>Sales Contract: ASP Change Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/Text_Sales_Contract_Change_ASP</template>
    </alerts>
    <alerts>
        <fullName>Sales_Contract_Change_Alert_1</fullName>
        <ccEmails>DL-SalesContracts@guardanthealth.com</ccEmails>
        <description>Sales Contract: Change Alert 1</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/Text_Sales_Contract_Change_ASP</template>
    </alerts>
    <alerts>
        <fullName>Sales_Contract_End_Date_Change_Alert</fullName>
        <ccEmails>DL-SalesContracts@guardanthealth.com</ccEmails>
        <description>Sales Contract: End Date Change Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/Text_Sales_Contract_Change_End_Date</template>
    </alerts>
    <alerts>
        <fullName>Sales_Contract_New_Contract_Created_Alert</fullName>
        <ccEmails>DL-SalesContracts@guardanthealth.com</ccEmails>
        <description>Sales Contract: New Contract Created Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Workflow_Templates/Text_Sales_Contract_New_Record_Created</template>
    </alerts>
    <fieldUpdates>
        <fullName>Fill_Active_Notify_Date</fullName>
        <field>SEC_Active_Notification_Date__c</field>
        <formula>Today()</formula>
        <name>Fill Active Notify Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fill_Terminated_Notify_Date</fullName>
        <field>SEC_Termination_Notification_Date__c</field>
        <formula>Today()</formula>
        <name>Fill Terminated Notify Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Contract_Previous_ASP</fullName>
        <field>Previous_ASP__c</field>
        <formula>PRIORVALUE(ASP__c)</formula>
        <name>Sales Contract: Previous ASP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Contract_Previous_End_Date</fullName>
        <field>Previous_End_Date__c</field>
        <formula>PRIORVALUE(End_Date__c )</formula>
        <name>Sales Contract: Previous End Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_with_Account_Type</fullName>
        <field>Account_Type__c</field>
        <formula>TEXT (Sales_Contract_Account__r.Account_Type__c)</formula>
        <name>Update with Account Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Active SEC Notify</fullName>
        <actions>
            <name>Notify_DL_SEC_is_Active</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Fill_Active_Notify_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Sales_Contract__c.Contract__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Sales_Contract__c.Status__c</field>
            <operation>equals</operation>
            <value>Signed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Sales_Contract__c.SEC_Active_Notification_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sales Contract%3A Previous ASP</fullName>
        <actions>
            <name>Sales_Contract_Previous_ASP</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates previous ASP field</description>
        <formula>ISCHANGED( ASP__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sales Contract%3A Previous End Date</fullName>
        <actions>
            <name>Sales_Contract_Previous_End_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates previous End Date field</description>
        <formula>ISCHANGED(End_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Terminated SEC Notify</fullName>
        <actions>
            <name>Notify_DL_SEC_is_Terminated</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Fill_Terminated_Notify_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Sales_Contract__c.Contract__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Sales_Contract__c.Status__c</field>
            <operation>equals</operation>
            <value>Terminated</value>
        </criteriaItems>
        <criteriaItems>
            <field>Sales_Contract__c.SEC_Termination_Notification_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Account Type</fullName>
        <actions>
            <name>Update_with_Account_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
