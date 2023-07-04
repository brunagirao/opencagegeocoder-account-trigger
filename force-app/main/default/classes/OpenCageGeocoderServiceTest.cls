/************************************************************************************************
* Name      : OpenCageGeocoderServiceTest
* Purpose   : Test class to OpenCageGeocoderService
* Author    : Bruna Girão
* Date      : 19-06-2023
***************************************************************************************************/
@IsTest
public with sharing class OpenCageGeocoderServiceTest {

    @TestSetup
    static void setup(){
        //Account records
        List<Account> accountList = new List<Account>();
        
        Account accountTestForward = new Account (
            Name                = 'Account Test Forward',
            AccountNumber       = '123456',
            ShippingStreet      = 'South Lexington Avenue',
            ShippingCity        = 'Burlington', 
            ShippingState       = 'North Carolina',
            ShippingPostalCode  = '27215',
            ShippingCountry     = 'US'
        );
        accountList.add(accountTestForward);

        Account accountTestReverse = new Account (
            Name                        = 'Account Test Reverse',
            AccountNumber               = '1234567',
            Location__latitude__s       = 36.0318,
            Location__longitude__s      = -79.4889
        );
        accountList.add(accountTestReverse);

        insert accountList;

        //Custom Settings
        OpenCageGeocoder_Settings__c openGeocoderSettings = new OpenCageGeocoder_Settings__c (
            Name        = 'Default',
            ApiKey__c   = 'qwerty123456789qwerty',
            Endpoint__c = '/geocode/v1/json?'
        );
        insert openGeocoderSettings;

    }
    
    @IsTest
    static void getForwardGeoCode_SuccessCall() {

        Account accountTestForward = [SELECT Id, Name, Location__latitude__s, 
                                             Location__longitude__s
                                        FROM Account
                                       WHERE Name = 'Account Test Forward'
                                       LIMIT 1];

 
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            OpenCageGeocoderService.getForwardGeoCode(new Set<Id>{accountTestForward.Id});
        Test.stopTest();
        
    }

    @IsTest
    static void getForwardGeoCode_ErrorCall() {
  
        Account accountTestForward = [SELECT Id, Name, ShippingStreet, ShippingCity,
                                             ShippingState, ShippingPostalCode, 
                                             ShippingCountry
                                        FROM Account
                                       WHERE Name = 'Account Test Forward'
                                       LIMIT 1];
                                       
        OpenCageGeocoder_Settings__c openGeocoderSettings = OpenCageGeocoder_Settings__c.getInstance('Default');
        openGeocoderSettings.ApiKey__c = '';
        update openGeocoderSettings;

        update accountTestForward;
    
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('ERROR_CALL'));
            OpenCageGeocoderService.getForwardGeoCode(new Set<Id>{accountTestForward.Id});
        Test.stopTest();
        
    }

    @IsTest
    static void getReverseGeoCode_SuccessCall() {

        Account accountTestForward = [SELECT Id, Name, Location__latitude__s, 
                                             Location__longitude__s
                                        FROM Account
                                       WHERE Name = 'Account Test Forward'
                                       LIMIT 1];

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            OpenCageGeocoderService.getReverseGeoCode(new Set<Id>{accountTestForward.Id});
        Test.stopTest();
        
    }

    @IsTest
    static void getReverseGeoCode_ErrorCall() {

        Account accountTestForward = [SELECT Id, Name, ShippingStreet, ShippingCity,
                                             ShippingState, ShippingPostalCode, 
                                             ShippingCountry
                                        FROM Account
                                       WHERE Name = 'Account Test Forward'
                                       LIMIT 1];
                                       
        OpenCageGeocoder_Settings__c openGeocoderSettings = OpenCageGeocoder_Settings__c.getInstance('Default');
        openGeocoderSettings.ApiKey__c = '';
        update openGeocoderSettings;

        update accountTestForward;
        System.debug('accountTestForward => ' + accountTestForward);
   
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('ERROR_CALL'));
            OpenCageGeocoderService.getReverseGeoCode(new Set<Id>{accountTestForward.Id});
        Test.stopTest();  
        
    }
}