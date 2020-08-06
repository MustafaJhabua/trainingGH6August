<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_ClinDev_LIMS_Project_data_to_DL_LIMS_Support</fullName>
        <ccEmails>DL-LIMS-Support@guardanthealth.com</ccEmails>
        <ccEmails>LIMS-Support@guardanthealth.com</ccEmails>
        <description>Send ClinDev LIMS Project data to DL-LIMS-Support</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ClinDev_LIMS_template</template>
    </alerts>
    <alerts>
        <fullName>Send_LIMS_Project_data_to_DL_LIMS_Support</fullName>
        <ccEmails>DL-LIMS-Support@guardanthealth.com</ccEmails>
        <ccEmails>LIMS-Support@guardanthealth.com</ccEmails>
        <ccEmails>DL-AllianceManagement@guardanthealth.com</ccEmails>
        <ccEmails>jnewman@guardanthealth.com</ccEmails>
        <ccEmails>accountsreceivable@guardanthealth.com</ccEmails>
        <description>Send Pharma LIMS Project data to DL-LIMS-Support</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Biopharma_LIMS_template</template>
    </alerts>
</Workflow>
