trigger ResendFax on efaxapp__Sent_Fax__c (before update) {
	List<efaxapp__Sent_Fax__c> toResend = new List<efaxapp__Sent_Fax__c>();
	for (efaxapp__Sent_Fax__c fax : Trigger.new){
		if(fax.Resend__c == true && Trigger.oldMap.get(fax.Id).Resend__c == false && fax.efaxapp__Parent_ID__c != null){
			toResend.add(fax);
		}
	}
	List<Id> attIds = new List<Id>();
	for(efaxapp__Sent_Fax__c fax : toResend){
		attIds.add(fax.efaxapp__Attachment_ID__c);
	}	
	List<Attachment> oldAttList = [Select Id, Name, Body, ParentId from Attachment where Id in :attIds];
	List<Attachment> newAttList = new List<Attachment>();
	for(Attachment att : oldAttList){
		newAttList.add(new Attachment(
			Name = att.Name,
		    Body = att.Body,
		    ParentId = att.ParentId
		));
	}
	insert newAttList;
	delete oldAttList;
}