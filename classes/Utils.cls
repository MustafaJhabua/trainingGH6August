public with sharing class Utils {


    /**
     * https://blog.jeffdouglas.com/2011/10/20/getting-salesforce-field-metadata-the-easy-way/
     *
     * @param dsor
     * @param fields
     *
     * @return
     */
    public static Map<String, Schema.DescribeFieldResult> getFieldMetaData(Schema.DescribeSObjectResult dsor, Set<String> fields) {
        Map<String, Schema.DescribeFieldResult> finalMap = new Map<String, Schema.DescribeFieldResult>();
        Map<String, Schema.SObjectField> objectFields = dsor.fields.getMap();
        for (String field : fields) {
            if (objectFields.containsKey(field)) {
                Schema.DescribeFieldResult dr = objectFields.get(field).getDescribe();
                finalMap.put(field, dr);
            }
        }
        return finalMap;
    }
}