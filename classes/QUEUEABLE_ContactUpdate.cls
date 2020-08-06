public with sharing class QUEUEABLE_ContactUpdate implements Queueable{
	public List<Contact> contactsToUpdate = new List<Contact>();
	public QUEUEABLE_ContactUpdate(List<Contact> contactsToUpdate) {
		this.contactsToUpdate = contactsToUpdate;
	}

	public void execute(QueueableContext context){
		update contactsToUpdate;
	}
}