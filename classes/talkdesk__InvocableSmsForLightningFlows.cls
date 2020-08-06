/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class InvocableSmsForLightningFlows {
    global InvocableSmsForLightningFlows() {

    }
    @InvocableMethod(label='Send SMS' description='Method to be invoked to send SMS')
    global static void sendSmsFromFlows(List<talkdesk.InvocableSmsForLightningFlows.SMSFlowInputs> values) {

    }
global class SMSFlowInputs {
    @InvocableVariable( required=true)
    global String message;
    @InvocableVariable( required=false)
    global String phoneNumber;
    global SMSFlowInputs() {

    }
}
}
