trigger MedPro_StateLicenseTriggers on MedPro_State_Licenses__c (before insert, before update)
{
    if (Trigger.isBefore && Trigger.isInsert)
    {
    	MedPro_StateLicenseTH.handleBeforeInsert();
    } else if (Trigger.isBefore && Trigger.isUpdate)
    {
    	MedPro_StateLicenseTH.handleBeforeUpdate();
    }
}