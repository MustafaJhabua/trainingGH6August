@isTest
private class MedPro_StateLicenseCheckNPITest
{
	@isTest static void testInsertMult()
	{
		Integer NUM_ROWS = 10;

		String npiId = 'npinum';
		List<MedPro_State_Licenses__c> msls = new List<MedPro_State_Licenses__c>();
		for (Integer i = 0; i < NUM_ROWS; i++)
		{
			msls.add(new MedPro_State_Licenses__c(MP_NPI_Number__c = npiId + i));
		}

		Test.startTest();
		insert msls;
		Test.stopTest();

		List<NPI_Records__c> npis = [SELECT Id FROM NPI_Records__c];
		System.assertEquals(NUM_ROWS, npis.size());
	}
	
	@isTest static void testInsertOne()
	{
		String npiId = 'npinum';
		
		Test.startTest();
		insert new MedPro_State_Licenses__c(MP_NPI_Number__c = npiId);
		Test.stopTest();

		List<NPI_Records__c> npis = [SELECT Id FROM NPI_Records__c WHERE NPI_Number__c = :npiId];
		System.assertEquals(1, npis.size());
	}
	
	@isTest static void testUpdate()
	{
		String npiId = 'npinum';
		String npiId2 = 'npinumber2';
		String fName1 = 'First1';
		String fName2 = 'First2';

		MedPro_State_Licenses__c msl = new MedPro_State_Licenses__c(MP_NPI_Number__c = npiId, NPI_First_Name__c = fName1);
		insert msl;
		
		Test.startTest();
		msl.MP_NPI_Number__c = npiId2;
		msl.NPI_First_Name__c = fName2;
		update msl;
		Test.stopTest();

		NPI_Records__c npi1 = [SELECT First_Name__c FROM NPI_Records__c WHERE NPI_Number__c = :npiId];
		System.assertEquals(fName1, npi1.First_Name__c);

		NPI_Records__c npi2 = [SELECT First_Name__c FROM NPI_Records__c WHERE NPI_Number__c = :npiId2];
		System.assertEquals(fName2, npi2.First_Name__c);

		msl = [SELECT NPI_Record__c FROM MedPro_State_Licenses__c];
		System.assertEquals(npi2.Id, msl.NPI_Record__c);
	}

	@isTest static void testUpdateNull()
	{
		String npiId = 'npinum';
		String npiId2 = 'npinumber2';
		String fName1 = 'First1';
		String fName2 = 'First2';

		MedPro_State_Licenses__c msl = new MedPro_State_Licenses__c(MP_NPI_Number__c = npiId, NPI_First_Name__c = fName1);
		insert msl;
		
		Test.startTest();
		msl.MP_NPI_Number__c = null;
		msl.NPI_First_Name__c = fName2;
		update msl;
		Test.stopTest();

		NPI_Records__c npi1 = [SELECT First_Name__c FROM NPI_Records__c WHERE NPI_Number__c = :npiId];
		System.assertEquals(fName1, npi1.First_Name__c);

		msl = [SELECT NPI_Record__c FROM MedPro_State_Licenses__c];
		System.assertEquals(null, msl.NPI_Record__c);
	}

	@isTest static void testEmptyNPI()
	{
		Test.startTest();
		insert new MedPro_State_Licenses__c();
		Test.stopTest();

		List<NPI_Records__c> npis = [SELECT Id FROM NPI_Records__c];
		System.assert(npis.isEmpty());
	}
}