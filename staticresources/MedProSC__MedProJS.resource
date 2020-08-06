/*
	Submit DRP
*/
{!REQUIRESCRIPT("/soap/ajax/14.0/connection.js")} 
{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")} 
{!REQUIRESCRIPT("/resource/MedPro_SC_API_JsLibrary_2_6")} 

var param1 = '{!Contact.Id}'; 
var param2 = 'Contact'; 

var nameSpaceToUse = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Namespace_Prefix__c}"; 
var isDebugEnabled = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Debug_Enabled__c}"; 

performDRPSubmissionForSpecificRecord(param1,param2,nameSpaceToUse);

-------------------------------------------------------------------------------------

/*
	Search MedPro
	This will check to see if the parent object has a MedProId.  If it doens't it will search
	MedPro for a similar record via the Search page.  Otherwise it will call an update to MedPro
	and update children records as well.
	This code assumes that the parent type is Contact.
	***Replace all instances of Contact with the parent record's type.***
*/
//Below is new code to determine if we are getting an update from MedPro or doing a search
{!REQUIRESCRIPT("/soap/ajax/14.0/connection.js")}
{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")}
{!REQUIRESCRIPT("/resource/MedPro_SC_API_JsLibrary_2_6")}
var med_id = '{!Contact.MedProSC__MedProID__c}';

//If medproid does not exist then pass in Contact.id to Search tool so first/last/sln# are pre-populated
if (med_id == '')
{
	var sfId = '{!Contact.Id}';
	var objectApiName = 'Contact';

	var nameSpaceToUse = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Namespace_Prefix__c}";
	var isDebugEnabled = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Debug_Enabled__c}";

	var result = sforce.apex.execute(nameSpaceToUse + "MedPro_SC_API",
	"getURLFromSearch",{sfId:sfId, objectApiName:objectApiName});

	window.location.href = result;
}
else
{
	var nameSpaceToUse = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Namespace_Prefix__c}";

	//MedPro ID exists so get an update from MedPro for CONTACT
	var parsfId = '{!Contact.Id}';
	var parentobjectApiName = 'Contact';

	var result = sforce.apex.execute(nameSpaceToUse + "MedPro_SC_API", "updateChildrenRecordsFromMedPro",{parsfId:parsfId,parentobjectApiName:parentobjectApiName});
	
	console.log ('result:' + result);
	if (result.indexOf(':') > -1) 
	{
		var theSplit = result.split(':'); 
		var mappingId = theSplit[1]; 
		var medIds = theSplit[2]; 
		result = theSplit[0]; 

		var emptyStr = ''; 
		var result2 = sforce.apex.execute(nameSpaceToUse + "MedPro_SC_API", "checkForRequiredInUniverseUpdate",{mappingId:mappingId, emptyStr:emptyStr, medIds:medIds}); // one call will get all the children mappings
/*
		if (result2.indexOf(':') > -1)
		{
			var split2 = result2.split(':');
			result2 = split2[0];
			var errorReturned = split2[1];
			alert('universe error: ' + errorReturned);
		}
		*/
	}

	alert(result);

	window.location.reload();
}

------------------------------------------------------------------------------------

/*
	Update Records from MedPro.
	Replace all instances of Contact with the parent object.
	Replace all isntances of ContactAddress__c with the child object.
*/
{!REQUIRESCRIPT("/soap/ajax/14.0/connection.js")} 
{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")} 
{!REQUIRESCRIPT("/resource/MedPro_SC_API_JsLibrary_2_6")} 

var parsfId = '{!Contact.Id}'; 
var objectApiName = 'Contact'; 

var nameSpaceToUse = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Namespace_Prefix__c}"; 
var parentmedproid = '{!Contact.MedProSC__MedProID__c}'; 

var result = sforce.apex.execute(nameSpaceToUse + "MedPro_SC_API", "updateChildrenRecordsFromMedPro",{parsfId:parsfId, objectApiName:objectApiName});

if (result.indexOf(':') > -1) 
{ 
	var theSplit = result.split(':'); 
	var mappingId = theSplit[1]; 
	var medIds = theSplit[2]; 
	result = theSplit[0]; 

	var emptyStr = ''; 
	var result2 = sforce.apex.execute(nameSpaceToUse + "MedPro_SC_API", "checkForRequiredInUniverseUpdate",{mappingId:mappingId, emptyStr:emptyStr, medIds:medIds});
}

alert(result); 
document.location.reload(true);

---------------------------------------------------------------------------------------------

/*
	Search MedPro.
	Take the User to the 'Search MedPro' page and when saving, will link the new records
	to the current record.
	Opens in the same tab.
	Replace 'Account' with the desired parent object.
*/
window.location.href = '/apex/MedProSearchPage?parentId={!Account.Id}'; 

---------------------------------------------------------------------------------------------

/*
	Search MedPro.
	Take the User to the 'Search MedPro' page and when saving, will link the new records
	to the current record.
	Opens in a new tab.
	Replace 'Account' with the desired parent object.
*/
window.open('/apex/MedProSearchPage?parentId={!Account.Id}', '_blank'); 

-----------------------------------------------------------------------------------------------

// This is where we want to add to Account that does not have any children

{!REQUIRESCRIPT("/soap/ajax/14.0/connection.js")} 
{!REQUIRESCRIPT("/soap/ajax/14.0/apex.js")} 

var nameSpaceToUse = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Namespace_Prefix__c}"; 

var isDebugEnabled = "{!$Setup.MedProSC__MedProAppSettings__c.MedProSC__Debug_Enabled__c}"; 

var med_id ='{!Account.MedProID__c}'; 

if (med_id == '') 
{ 
   var ilen =nameSpaceToUse.length; 
   if (nameSpaceToUse.substring(ilen-1,ilen)=='.') 
   { 
      nameSpaceToUse=nameSpaceToUse.substring(0 , ilen- 1); 
   } 
//
// Change P2 to point to last name and P3 to first name if account has breakdown.
   window.open('/apex/' +nameSpaceToUse + '__'+ 'MedProSearchPage?sfID={!Account.Id}&p2={!Account.Name}&p3={!Account.Name}', '_blank'); 
} 
else 
{ 
   // MedPro ID exists so get an update from MedPro for ACCOUNT
   var parsfId = '{!Account.Id}'; 
   var parentobjectApiName = 'Account'; 

   var result = sforce.apex.execute(nameSpaceToUse + "MedPro_SC_API", "updateChildrenRecordsFromMedPro",{parsfId:parsfId,parentobjectApiName:parentobjectApiName});
 
   alert(result);
   window.location.reload(); 
}





