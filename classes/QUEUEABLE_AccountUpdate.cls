public with sharing class QUEUEABLE_AccountUpdate implements Queueable{
	public List<Account> accountsToUpdate = new List<Account>();

	public QUEUEABLE_AccountUpdate(List<Account> accountsToUpdate) {
		this.accountsToUpdate = accountsToUpdate;
	}

	public void execute(QueueableContext context){
		update accountsToUpdate;
	}
}