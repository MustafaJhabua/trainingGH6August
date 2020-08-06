public with sharing class ConfigService {



    /** Default config options */
    private static Config settings {
        get {
            // Use cached value, if any, unless in test context
            return (settings != null && !Test.isRunningTest()) ?
                    settings
                    : new Config();
        }
    }

    /** Debug state */
    public static Boolean debugEnabled {
        get {
            return settings.debugEnabled;
        }
    }

    public static String matchPortalEndpoint {
        get {
            return settings.matchPortalEndpoint;
        }
    }

    public static String matchPortalToken {
        get {
            return settings.matchPortalToken;
        }
    }

    private class Config {
        private Boolean isSandbox = Url.getSalesforceBaseUrl().getHost().containsIgnoreCase('cs');
        private String orgTypeName = isSandbox ? 'Sandbox' : 'Production';

        /** Default Config Settings */
        private Config__mdt defaultSettings = Test.isRunningTest() ? null : [
                SELECT Debug__c, Enable_Logging__c
                FROM Config__mdt
                WHERE DeveloperName = 'Default'
        ];
        private Match_Portal_Configuration__mdt defaultMatchPortalSettings = Test.isRunningTest() ? null : [
                SELECT Endpoint__c, Token__c
                FROM Match_Portal_Configuration__mdt
                WHERE DeveloperName = :orgTypeName
        ];

        private String matchPortalEndpoint;
        private Boolean debugEnabled;
        private String matchPortalToken;

        private Config() {
            this.debugEnabled = Test.isRunningTest() ? true : defaultSettings.Debug__c;
            this.matchPortalEndpoint = Test.isRunningTest() ? 'test' : defaultMatchPortalSettings.Endpoint__c;
            this.matchPortalToken = Test.isRunningTest() ? 'test' : defaultMatchPortalSettings.Token__c;
        }
    }
}