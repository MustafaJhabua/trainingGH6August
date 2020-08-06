public with sharing class QUEUEABLE_AffilationUpdate implements Queueable{
	public List<Affilation__c> affiliationsToUpdate = new List<Affilation__c>();
	
	public QUEUEABLE_AffilationUpdate(List<Affilation__c> affiliationsToUpdate) {
		this.affiliationsToUpdate = affiliationsToUpdate;
	}

	public void execute(QueueableContext context){
		update affiliationsToUpdate;
	}
}