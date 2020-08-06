public with sharing class AvoidRecursion {
    private static Boolean firstRun = true;
    public static Boolean isFirstRun(){
        if(firstRun){
            firstRun = false;
            return true;
        }else{
            return firstRun;
        }
    }
}