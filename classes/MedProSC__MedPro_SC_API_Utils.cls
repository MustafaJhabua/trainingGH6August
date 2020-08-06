/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class MedPro_SC_API_Utils {
    global static Integer STATUS_ACCEPTED;
    global static Integer STATUS_BAD;
    global static Integer STATUS_CREATED;
    global static Integer STATUS_FORBIDDEN;
    global static Integer STATUS_ISE;
    global static Integer STATUS_NO_CUSTOMER;
    global static Integer STATUS_NOTALLOWED;
    global static Integer STATUS_NOTFOUND;
    global static Integer STATUS_OK;
    global MedPro_SC_API_Utils() {

    }
global class API_Simple_Result {
    @WebService
    webService Integer medProScExceptionCode;
    @WebService
    webService String message;
    @WebService
    webService Integer returnCode;
}
global class API_URL_Result {
    @WebService
    webService Integer medProScExceptionCode;
    @WebService
    webService String message;
    @WebService
    webService Integer returnCode;
    @WebService
    webService String url;
}
}
