<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Sales_That_Lead_is_Pending</fullName>
        <description>Alert Sales That Lead is Pending</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/LeadsNewassignmentnotification</template>
    </alerts>
    <alerts>
        <fullName>EmailAlertOnRequestAKit</fullName>
        <ccEmails>clientservices@guardanthealth.com</ccEmails>
        <description>EmailAlertOnRequestAKit</description>
        <protected>false</protected>
        <senderAddress>cdaglow@guardanthealth.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/LeadUpdateOnRequestAkit</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Med_Affairs_for_lead</fullName>
        <description>Assign to Med Affairs User</description>
        <protected>false</protected>
        <recipients>
            <recipient>matasks@guardanthealth.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Email_to_Med_Affairs</template>
    </alerts>
    <alerts>
        <fullName>Lead_Assignment_Notification_Client_Services</fullName>
        <ccEmails>clientservices@guardanthealth.com</ccEmails>
        <description>Lead Assignment Notification Client Services</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Client_Services_Email_Templates/Leads_New_assignment_notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Fill_Country_for_International_Leads</fullName>
        <field>Country</field>
        <formula>CASE( Country_of_Residence__c, 
&apos;Afghanistan&apos;,&apos;AF&apos;,
&apos;Albania&apos;,&apos;AL&apos;,
&apos;Algeria&apos;,&apos;DZ&apos;,
&apos;American Samoa&apos;,&apos;AS&apos;,
&apos;Andorra&apos;,&apos;AD&apos;,
&apos;Angola&apos;,&apos;AO&apos;,
&apos;Anguilla&apos;,&apos;AI&apos;,
&apos;Antigua and Barbuda&apos;,&apos;AG&apos;,
&apos;Argentina&apos;,&apos;AR&apos;,
&apos;Armenia&apos;,&apos;AM&apos;,
&apos;Aruba&apos;,&apos;AW&apos;,
&apos;Australia&apos;,&apos;AU&apos;,
&apos;Austria&apos;,&apos;AT&apos;,
&apos;Azerbaijan&apos;,&apos;AZ&apos;,
&apos;Bahamas&apos;,&apos;BS&apos;,
&apos;Bahrain&apos;,&apos;BH&apos;,
&apos;Bangladesh&apos;,&apos;BD&apos;,
&apos;Barbados&apos;,&apos;BB&apos;,
&apos;Belarus&apos;,&apos;BY&apos;,
&apos;Belgium&apos;,&apos;BE&apos;,
&apos;Belize&apos;,&apos;BZ&apos;,
&apos;Benin&apos;,&apos;BJ&apos;,
&apos;Bermuda&apos;,&apos;BM&apos;,
&apos;Bhutan&apos;,&apos;BT&apos;,
&apos;Bolivia&apos;,&apos;BO&apos;,
&apos;Bosnia and Herzegovina&apos;,&apos;BA&apos;,
&apos;Botswana&apos;,&apos;BW&apos;,
&apos;Bouvet Island&apos;,&apos;BV&apos;,
&apos;Brazil&apos;,&apos;BR&apos;,
&apos;British Virgin Islands&apos;,&apos;VG&apos;,
&apos;Bulgaria&apos;,&apos;BG&apos;,
&apos;Burundi&apos;,&apos;BI&apos;,
&apos;Cambodia&apos;,&apos;KH&apos;,
&apos;Cameroon&apos;,&apos;CM&apos;,
&apos;Canada&apos;,&apos;CA&apos;,
&apos;Cape Verde&apos;,&apos;CV&apos;,
&apos;Cayman Islands&apos;,&apos;KY&apos;,
&apos;Central African Republic&apos;,&apos;CF&apos;,
&apos;Chad&apos;,&apos;TD&apos;,
&apos;Chile&apos;,&apos;CL&apos;,
&apos;China&apos;,&apos;CN&apos;,
&apos;Hong Kong&apos;,&apos;HK&apos;,
&apos;Macao&apos;,&apos;MO&apos;,
&apos;Colombia&apos;,&apos;CO&apos;,
&apos;Congo&apos;,&apos;CD&apos;,
&apos;Cook Islands&apos;,&apos;CK&apos;,
&apos;Costa Rica&apos;,&apos;CR&apos;,
&apos;Ivory Coast&apos;,&apos;CI&apos;,
&apos;Croatia&apos;,&apos;HR&apos;,
&apos;Cuba&apos;,&apos;CU&apos;,
&apos;Cyprus&apos;,&apos;CY&apos;,
&apos;Czech Republic&apos;,&apos;CZ&apos;,
&apos;Denmark&apos;,&apos;DK&apos;,
&apos;Djibouti&apos;,&apos;DJ&apos;,
&apos;Dominican Republic&apos;,&apos;DO&apos;,
&apos;Ecuador&apos;,&apos;EC&apos;,
&apos;Egypt&apos;,&apos;EG&apos;,
&apos;El Salvador&apos;,&apos;SV&apos;,
&apos;Equatorial Guinea&apos;,&apos;GQ&apos;,
&apos;Eritrea&apos;,&apos;ER&apos;,
&apos;Estonia&apos;,&apos;EE&apos;,
&apos;Ethiopia&apos;,&apos;ET&apos;,
&apos;Falkland Islands&apos;,&apos;FK&apos;,
&apos;Fiji&apos;,&apos;FJ&apos;,
&apos;Finland&apos;,&apos;FI&apos;,
&apos;France&apos;,&apos;FR&apos;,
&apos;French Guiana&apos;,&apos;GF&apos;,
&apos;French Polynesia&apos;,&apos;PF&apos;,
&apos;Gabon&apos;,&apos;GA&apos;,
&apos;Gambia&apos;,&apos;GM&apos;,
&apos;Georgia&apos;,&apos;GE&apos;,
&apos;Germany&apos;,&apos;DE&apos;,
&apos;Ghana&apos;,&apos;GH&apos;,
&apos;Gibraltar&apos;,&apos;GI&apos;,
&apos;Greece&apos;,&apos;GR&apos;,
&apos;Greenland&apos;,&apos;GL&apos;,
&apos;Grenada&apos;,&apos;GD&apos;,
&apos;Guadeloupe&apos;,&apos;GP&apos;,
&apos;Guam&apos;,&apos;GU&apos;,
&apos;Guatemala&apos;,&apos;GT&apos;,
&apos;Guinea&apos;,&apos;GN&apos;,
&apos;Guyana&apos;,&apos;GY&apos;,
&apos;Haiti&apos;,&apos;HT&apos;,
&apos;Vatican City&apos;,&apos;VA&apos;,
&apos;Honduras&apos;,&apos;HN&apos;,
&apos;Hungary&apos;,&apos;HU&apos;,
&apos;Iceland&apos;,&apos;IS&apos;,
&apos;India&apos;,&apos;IN&apos;,
&apos;Indonesia&apos;,&apos;ID&apos;,
&apos;Iran&apos;,&apos;IR&apos;,
&apos;Iraq&apos;,&apos;IQ&apos;,
&apos;Ireland&apos;,&apos;IE&apos;,
&apos;Israel&apos;,&apos;IL&apos;,
&apos;Italy&apos;,&apos;IT&apos;,
&apos;Jamaica&apos;,&apos;JM&apos;,
&apos;Japan&apos;,&apos;JP&apos;,
&apos;Jersey&apos;,&apos;JE&apos;,
&apos;Jordan&apos;,&apos;JO&apos;,
&apos;Kazakhstan&apos;,&apos;KZ&apos;,
&apos;Kenya&apos;,&apos;KE&apos;,
&apos;South Korea&apos;,&apos;KR&apos;,
&apos;Kuwait&apos;,&apos;KW&apos;,
&apos;Kyrgyzstan&apos;,&apos;KG&apos;,
&apos;Laos&apos;,&apos;LA&apos;,
&apos;Latvia&apos;,&apos;LV&apos;,
&apos;Lebanon&apos;,&apos;LB&apos;,
&apos;Lesotho&apos;,&apos;LS&apos;,
&apos;Liberia&apos;,&apos;LR&apos;,
&apos;Libya&apos;,&apos;LY&apos;,
&apos;Liechtenstein&apos;,&apos;LI&apos;,
&apos;Lithuania&apos;,&apos;LT&apos;,
&apos;Luxembourg&apos;,&apos;LU&apos;,
&apos;Macedonia&apos;,&apos;MK&apos;,
&apos;Madagascar&apos;,&apos;MG&apos;,
&apos;Malawi&apos;,&apos;MW&apos;,
&apos;Malaysia&apos;,&apos;MY&apos;,
&apos;Maldives&apos;,&apos;MV&apos;,
&apos;Mali&apos;,&apos;ML&apos;,
&apos;Malta&apos;,&apos;MT&apos;,
&apos;Martinique&apos;,&apos;MQ&apos;,
&apos;Mauritania&apos;,&apos;MR&apos;,
&apos;Mexico&apos;,&apos;MX&apos;,
&apos;Micronesia&apos;,&apos;FM&apos;,
&apos;Moldova&apos;,&apos;MD&apos;,
&apos;Monaco&apos;,&apos;MC&apos;,
&apos;Mongolia&apos;,&apos;MN&apos;,
&apos;Montenegro&apos;,&apos;ME&apos;,
&apos;Montserrat&apos;,&apos;MS&apos;,
&apos;Morocco&apos;,&apos;MA&apos;,
&apos;Mozambique&apos;,&apos;MZ&apos;,
&apos;Myanmar&apos;,&apos;MM&apos;,
&apos;Namibia&apos;,&apos;NA&apos;,
&apos;Nepal&apos;,&apos;NP&apos;,
&apos;Netherlands&apos;,&apos;NL&apos;,
&apos;New Caledonia&apos;,&apos;NC&apos;,
&apos;New Zealand&apos;,&apos;NZ&apos;,
&apos;Nicaragua&apos;,&apos;NI&apos;,
&apos;Niger&apos;,&apos;NE&apos;,
&apos;Nigeria&apos;,&apos;NG&apos;,
&apos;Norfolk Island&apos;,&apos;NF&apos;,
&apos;Norway&apos;,&apos;NO&apos;,
&apos;Oman&apos;,&apos;OM&apos;,
&apos;Pakistan&apos;,&apos;PK&apos;,
&apos;Palau&apos;,&apos;PW&apos;,
&apos;Palestine&apos;,&apos;PS&apos;,
&apos;Panama&apos;,&apos;PA&apos;,
&apos;Papua New Guinea&apos;,&apos;PG&apos;,
&apos;Paraguay&apos;,&apos;PY&apos;,
&apos;Peru&apos;,&apos;PE&apos;,
&apos;Philippines&apos;,&apos;PH&apos;,
&apos;Poland&apos;,&apos;PL&apos;,
&apos;Portugal&apos;,&apos;PT&apos;,
&apos;Puerto Rico&apos;,&apos;PR&apos;,
&apos;Qatar&apos;,&apos;QA&apos;,
&apos;Romania&apos;,&apos;RO&apos;,
&apos;Russia&apos;,&apos;RU&apos;,
&apos;Rwanda&apos;,&apos;RW&apos;,
&apos;Samoa&apos;,&apos;WS&apos;,
&apos;San Marino&apos;,&apos;SM&apos;,
&apos;Saudi Arabia&apos;,&apos;SA&apos;,
&apos;Senegal&apos;,&apos;SN&apos;,
&apos;Serbia&apos;,&apos;RS&apos;,
&apos;Seychelles&apos;,&apos;SC&apos;,
&apos;Sierra Leone&apos;,&apos;SL&apos;,
&apos;Singapore&apos;,&apos;SG&apos;,
&apos;Slovakia&apos;,&apos;SK&apos;,
&apos;Slovenia&apos;,&apos;SI&apos;,
&apos;Solomon Islands&apos;,&apos;SB&apos;,
&apos;Somalia&apos;,&apos;SO&apos;,
&apos;South Africa&apos;,&apos;ZA&apos;,
&apos;Spain&apos;,&apos;ES&apos;,
&apos;Sri Lanka&apos;,&apos;LK&apos;,
&apos;Sudan&apos;,&apos;SD&apos;,
&apos;Suriname&apos;,&apos;SR&apos;,
&apos;Swaziland&apos;,&apos;SZ&apos;,
&apos;Sweden&apos;,&apos;SE&apos;,
&apos;Switzerland&apos;,&apos;CH&apos;,
&apos;Taiwan&apos;,&apos;TW&apos;,
&apos;Tajikistan&apos;,&apos;TJ&apos;,
&apos;Tanzania&apos;,&apos;TZ&apos;,
&apos;Thailand&apos;,&apos;TH&apos;,
&apos;Togo&apos;,&apos;TG&apos;,
&apos;Tonga&apos;,&apos;TO&apos;,
&apos;Trinidad and Tobago&apos;,&apos;TT&apos;,
&apos;Tunisia&apos;,&apos;TN&apos;,
&apos;Turkey&apos;,&apos;TR&apos;,
&apos;Turkmenistan&apos;,&apos;TM&apos;,
&apos;Uganda&apos;,&apos;UG&apos;,
&apos;Ukraine&apos;,&apos;UA&apos;,
&apos;United Arab Emirates&apos;,&apos;AE&apos;,
&apos;United Kingdom&apos;,&apos;GB&apos;,
&apos;United States&apos;,&apos;US&apos;,
&apos;USA&apos;,&apos;US&apos;,
&apos;Uruguay&apos;,&apos;UY&apos;,
&apos;Uzbekistan&apos;,&apos;UZ&apos;,
&apos;Vanuatu&apos;,&apos;VU&apos;,
&apos;Venezuela&apos;,&apos;VE&apos;,
&apos;Vietnam&apos;,&apos;VN&apos;,
&apos;Virgin Islands&apos;,&apos;VI&apos;,
&apos;Yemen&apos;,&apos;YE&apos;,
&apos;Zambia&apos;,&apos;ZM&apos;,
&apos;Zimbabwe&apos;,&apos;ZW&apos;,
&apos;US&apos;
)</formula>
        <name>Fill Country for International Leads</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pardot_Lead_Reassign</fullName>
        <field>Pardot_Lead_Reassign__c</field>
        <literalValue>1</literalValue>
        <name>Pardot Lead Reassign</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_C19_form_sent</fullName>
        <field>Date_Covid_19_Consent_Form_Sent__c</field>
        <formula>TODAY()</formula>
        <name>Update Date C19 form sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Pardot_Reassign_Checkbox_Field</fullName>
        <field>Pardot_Lead_Reassign__c</field>
        <literalValue>1</literalValue>
        <name>Update Pardot Reassign Checkbox Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Pardot Lead Reassign</fullName>
        <actions>
            <name>Pardot_Lead_Reassign</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Request_a_Kit_Details__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Pardot_Lead_Reassign__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>RequestAKitOnLead</fullName>
        <actions>
            <name>EmailAlertOnRequestAKit</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Requestakit__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This will send out an email to CS team whenever a lead record is created from request a kit form</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Unopened Leads Notification</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Lead.Inquiry_Type__c</field>
            <operation>equals</operation>
            <value>New Medical Professional</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.IsConverted</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Cancel_Workflow__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Alert_Sales_That_Lead_is_Pending</name>
                <type>Alert</type>
            </actions>
            <timeLength>5</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Alert_Sales_That_Lead_is_Pending</name>
                <type>Alert</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Alert_Sales_That_Lead_is_Pending</name>
                <type>Alert</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Country</fullName>
        <actions>
            <name>Fill_Country_for_International_Leads</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Date Covid-19 form sent</fullName>
        <actions>
            <name>Update_Date_C19_form_sent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Covid_19_Consent_Form_Sent__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
