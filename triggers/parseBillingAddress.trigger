trigger parseBillingAddress on Account (before insert, before update) {
    AddressParse.parseAddress(trigger.new, 'BillingStreet', 'Billing_Street_1__c', 'Billing_Street_2__c');
    AddressParse.parseAddress(trigger.new, 'ShippingStreet', 'Shipping_Street_1__c', 'Shipping_Street_2__c');

    AccountTerritories.setAccountTerritories(trigger.new);
}