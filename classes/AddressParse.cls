public class AddressParse {
    //This function must be called from a 'before' trigger.
    public static void parseAddress(List<SObject> lstObj, string fldSource, string fldAddress1, string fldAddress2) {
        String strSource = null;
        List<String> parts = null;

        for(SObject o: lstobj) {
            strSource = (String)o.get(fldSource);
            
            if(strSource != null) {
                parts = strSource.split('\n');

                if( parts.size() >= 1 ) {
                    o.put(fldAddress1, parts[0]);
                }
                   
                if( parts.size() >= 2 ) {
                    o.put(fldAddress2, parts[1]);
                } else {
                    o.put(fldAddress2, '');
                }

            } else {
                o.put(fldAddress1, '');
                o.put(fldAddress2, ''); 
            }
        }
     }
}