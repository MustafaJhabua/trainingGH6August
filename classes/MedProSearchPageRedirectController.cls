public with sharing class MedProSearchPageRedirectController
{
    private MedProSC__MedProCustomer__c currCustomer;
    private Map<String, String> paramsOnpage;

    public MedProSearchPageRedirectController()
    {
        paramsOnpage = ApexPages.currentPage().getParameters();
    }

    public pagereference redirect()
    {
        
        String s = '';
        String mpAction = '';
        String refId = '';
        
        //System.debug(paramsOnPage);
        
        if (paramsOnPage.containskey('parentId'))
        {
            refId = paramsOnPage.get('parentId');
            s = '/'+ refId;
        }
        else if (paramsOnPage.containskey('id'))
        {
            refId = paramsOnPage.get('id');
            s = '/'+ refId;
        }
        else
        {
            s = '/';
        }
        
        return new PageReference(s);
    }
}