public with sharing class MedPro_StateLicenseTH
{
    public static void handleBeforeInsert()
    {
        checkNPI(Trigger.new);
    }

    public static void handleBeforeUpdate()
    {
        checkNPI(Trigger.new);
    }

    public static void checkNPI(List<MedPro_State_Licenses__c> checkNPIs)
    {
        Set<String> npiIds = new Set<String>();
        for (MedPro_State_Licenses__c msl: checkNPIs)
        {
            if (!String.isBlank(msl.MP_NPI_Number__c))
                npiIds.add(msl.MP_NPI_Number__c);
        }
        System.debug('npiIds = ' + npiIds);

        List<NPI_Records__c> npis = [SELECT NPI_Number__c FROM NPI_Records__c WHERE NPI_Number__c IN :npiIds];
        Map<String, NPI_Records__c> npiMap = new Map<String, NPI_Records__c>();
        for (NPI_Records__c npi: npis)
        {
            npiMap.put(npi.NPI_Number__c, npi);
        }

        Set<String> npiInsertIds = new Set<String>();
        List<NPI_Records__c> newNPIs = new List<NPI_Records__c>();
        for (MedPro_State_Licenses__c msl: checkNPIs)
        {
            String npiId = msl.MP_NPI_Number__c;
            if (String.isBlank(npiId))
            {
                continue;
            }
            NPI_Records__c npi = npiMap.get(npiId);
            if (npi == null)
            {
                npi = new NPI_Records__c(NPI_Number__c = npiId);
                newNPIs.add(npi);
                npiMap.put(npiId, npi);
                npiInsertIds.add(npiId);
            }

            npi.First_Name__c = msl.NPI_First_Name__c;
            npi.Gender__c = msl.Gender__c;
            npi.Graduation_Year__c = msl.Graduation_Year__c;
            npi.Group_Practice_Name__c = msl.Group_Practice_Name__c;
            npi.MedPro_Last_Update__c = msl.MedPro_Last_Update__c;
            npi.Last_Name__c = msl.NPI_Last_Name__c;
            npi.NPI_STATE__c = msl.mp_npi_state__c;
            npi.MP_NPI_Active__c = msl.MP_NPI_Active__c;
            npi.NPI_City__c = msl.MP_NPI_City__c;
            npi.MP_PECOS_O_R__c = msl.MP_PECOS_O_R__c;
        }
        System.debug('newNPIs = ' + newNPIs);
        if (!newNPIs.isEmpty())
        {
            insert newNPIs;
        }
        List<NPI_Records__c> npiUpdates = new List<NPI_Records__c>();
        for (NPI_Records__c npi: npiMap.values())
        {
            if (!npiInsertIds.contains(npi.NPI_Number__c))
            {
                npiUpdates.add(npi);
            }
        }
        System.debug('npiUpdates = ' + npiUpdates);
        if (!npiUpdates.isEmpty())
        {
            update npiUpdates;
        }

        for (MedPro_State_Licenses__c msl: checkNPIs)
        {
            String npiId = msl.MP_NPI_Number__c;
            if (String.isBlank(npiId))
            {
                msl.NPI_Record__c = null;
                continue;
            }

            NPI_Records__c npi = npiMap.get(npiId);
            msl.NPI_Record__c = npi.Id;
        }
        System.debug('checkNPIDs = ' + checkNPIs);
    }
}