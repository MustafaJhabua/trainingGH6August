/**********************************************
  Author : Siva
  Description : This class will be called from the Match record list view button 

*************************************************/
global class runSyncCheck_Button {
    Webservice static void callRunSync(){
    // call the future method to make callout
        runSyncPortal.runSyncChecker();
    }
}