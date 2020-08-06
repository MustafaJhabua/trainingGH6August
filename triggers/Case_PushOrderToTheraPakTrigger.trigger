trigger Case_PushOrderToTheraPakTrigger on Case (after insert, after update) {

    if(PushOrderToTheraPak.runonce()) {
        PushOrderToTheraPak.start(trigger.new);
    }

}