/************************************************************************************************
* Name      : AccountTriggerTest
* Purpose   : Test Class to Account Trigger
* Author    : Bruna Girão
* Date      : 22-06-2023
***************************************************************************************************/

@IsTest
public with sharing class AccountHelperTest {

    @TestSetup
    static void setup() {

        //Custom Settings
        OpenCageGeocoder_Settings__c openGeocoderSettings = new OpenCageGeocoder_Settings__c (
            Name        = 'Default',
            ApiKey__c   = 'qwerty123456789qwerty',
            Endpoint__c = '/geocode/v1/json?'
        );
        insert openGeocoderSettings;
    }

    @IsTest
    static void fillLocationCoordinatesFields_InsertAccounts_HasAddressField() {
        
        //Given
        List<Account> accountsToInsertList = createAccountWithShippingAddress(50);
        insert accountsToInsertList;

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            AccountHelper.fillLocationCoordinatesFields(new Map<Id,Account>(accountsToInsertList), null);
        Test.stopTest();
    
        //Then
        List<Account> accountsInsertedList = [
            SELECT Id, Location__latitude__s, Location__longitude__s, Location_Link__c
              FROM Account
             WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.isNotNull(accountsInsertedList[0].Location_Link__c);
        System.Assert.isNotNull(accountsInsertedList[0].Location__latitude__s);
        System.Assert.isNotNull(accountsInsertedList[0].Location__longitude__s);
    }

    @IsTest
    static void fillLocationCoordinatesFields_InsertAccounts_HasNotAddressField() {
        
        //Given
        List<Account> accountsToInsertList = createAccountWithoutShippingAddress(50);
        insert accountsToInsertList;

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('ERROR_CALL'));
            AccountHelper.fillLocationCoordinatesFields(new Map<Id,Account>(accountsToInsertList), null);
        Test.stopTest();

        //Then
        List<Account> accountsInsertedList = [
            SELECT Id, Location__latitude__s, Location__longitude__s, Location_Link__c
              FROM Account
             WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.isNull(accountsInsertedList[0].Location_Link__c);
        System.Assert.isNull(accountsInsertedList[0].Location__latitude__s);
        System.Assert.isNull(accountsInsertedList[0].Location__longitude__s);
    }

    @IsTest
    static void fillLocationCoordinatesFields_UpdateAccounts_HasAddressFieldChanged() {
        
        //Given
        List<Account> accountsToInsertList = createAccountWithShippingAddress(50);
        insert accountsToInsertList;
        List<Account> accountsToUpdateList = new List<Account>();

        Integer i = 0;
        for(Account acc : accountsToInsertList) {
            Account acct = new Account (
                Id                  = acc.Id,
                Name                = acc.Name,
                ShippingStreet      = acc.ShippingStreet + 'Updated ' + i++,
                ShippingCity        = acc.ShippingCity, 
                ShippingState       = acc.ShippingState,
                ShippingPostalCode  = acc.ShippingPostalCode + i++,
                ShippingCountry     = acc.ShippingCountry
            );
            accountsToUpdateList.add(acct);
        }

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            AccountHelper.fillLocationCoordinatesFields(new Map<Id,Account>(accountsToUpdateList), new Map<Id,Account>(accountsToInsertList));
        Test.stopTest();

        //Then

        List<Account> accountsInsertedList = [
            SELECT Id, Location__latitude__s, Location__longitude__s, Location_Link__c
            FROM Account
            WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.areEqual(50, accountsToUpdateList.size());
        System.Assert.areNotEqual(accountsInsertedList[0].Location_Link__c, accountsToUpdateList[0].Location_Link__c);
        System.Assert.areNotEqual(accountsInsertedList[0].Location__latitude__s, accountsToUpdateList[0].Location__latitude__s);
        System.Assert.areNotEqual(accountsInsertedList[0].Location__longitude__s, accountsToUpdateList[0].Location__longitude__s);
    }

    @IsTest
    static void fillLocationCoordinatesFields_UpdateAccounts_HasNotAddressFieldChanged() {
        
        //Given
        List<Account> accountsToInsertList = createAccountWithShippingAddress(50);
        insert accountsToInsertList;
        List<Account> accountsToUpdateList = accountsToInsertList.clone();

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            AccountHelper.fillLocationCoordinatesFields(new Map<Id,Account>(accountsToUpdateList), new Map<Id,Account>(accountsToInsertList));
        Test.stopTest();

        //Then
        List<Account> accountsInsertedList = [
            SELECT Id, Location__latitude__s, Location__longitude__s, Location_Link__c
            FROM Account
            WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.areEqual(50, accountsToUpdateList.size());
        System.Assert.areEqual(accountsInsertedList[0].Location_Link__c, accountsToUpdateList[0].Location_Link__c);
        System.Assert.areEqual(accountsInsertedList[0].Location__latitude__s, accountsToUpdateList[0].Location__latitude__s);
        System.Assert.areEqual(accountsInsertedList[0].Location__longitude__s, accountsToUpdateList[0].Location__longitude__s);
    }

    @IsTest
    static void ffillShippingAddressFields_InsertAccounts_HasAddressField() {

        //Given
        List<Account> accountsToInsertList = createAccountWithCoordinateLocation(50);
        insert accountsToInsertList;

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            AccountHelper.fillShippingAddressFields(new Map<Id,Account>(accountsToInsertList), null);
        Test.stopTest();
    
        //Then
        List<Account> accountsInsertedList = [
            SELECT Id, ShippingStreet, ShippingCity, ShippingState,
                   ShippingPostalCode, ShippingCountry
              FROM Account
             WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.isNotNull(accountsInsertedList[0].ShippingStreet);
        System.Assert.isNotNull(accountsInsertedList[0].ShippingCity);
        System.Assert.isNotNull(accountsInsertedList[0].ShippingState);
        System.Assert.isNotNull(accountsInsertedList[0].ShippingPostalCode);
        System.Assert.isNotNull(accountsInsertedList[0].ShippingCountry);
    }


    
    @IsTest
    static void fillShippingAddressFields_InsertAccounts_HasNotAddressField() {
        
        //Given
        List<Account> accountsToInsertList = createAccountWithoutShippingAddress(50);
        insert accountsToInsertList;
        System.debug('accountsToInsertList[0] =>' + accountsToInsertList[0].ShippingStreet);

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('ERROR_CALL'));
            AccountHelper.fillShippingAddressFields(new Map<Id,Account>(accountsToInsertList), null);
        Test.stopTest();

        //Then
        List<Account> accountsInsertedList = [
            SELECT Id, ShippingStreet, ShippingCity, ShippingState,
                   ShippingPostalCode, ShippingCountry
              FROM Account
             WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.isNull(accountsInsertedList[0].ShippingStreet);
        System.Assert.isNull(accountsInsertedList[0].ShippingCity);
        System.Assert.isNull(accountsInsertedList[0].ShippingState);
        System.Assert.isNull(accountsInsertedList[0].ShippingPostalCode);
        System.Assert.isNull(accountsInsertedList[0].ShippingCountry);
    }

    
    @IsTest
    static void ffillShippingAddressFields_UpdateAccounts_HasAddressFieldChanged() {
        
        //Given
        List<Account> accountsToInsertList = createAccountWithCoordinateLocation(50);
        insert accountsToInsertList;
        List<Account> accountsToUpdateList = new List<Account>();

        Integer i = 0;
        for(Account acc : accountsToInsertList) {
            Account acct = new Account (
                Id                      = acc.Id,
                Name                    = acc.Name,
                Location__latitude__s   = 36.0318    + i++,
                Location__longitude__s  = -79.4889   + i++
            );
            accountsToUpdateList.add(acct);
        }

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            AccountHelper.fillShippingAddressFields(new Map<Id,Account>(accountsToUpdateList), new Map<Id,Account>(accountsToInsertList));
        Test.stopTest();

        //Then
        List<Account> accountsInsertedList = [
            SELECT Id, ShippingStreet, ShippingCity, ShippingState,
                   ShippingPostalCode, ShippingCountry
              FROM Account
             WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.areEqual(50, accountsToUpdateList.size());
        System.Assert.areNotEqual(accountsInsertedList[0].ShippingStreet, accountsToUpdateList[0].ShippingStreet);
        System.Assert.areNotEqual(accountsInsertedList[0].ShippingCity, accountsToUpdateList[0].ShippingCity);
        System.Assert.areNotEqual(accountsInsertedList[0].ShippingState, accountsToUpdateList[0].ShippingState);
        System.Assert.areNotEqual(accountsInsertedList[0].ShippingPostalCode, accountsToUpdateList[0].ShippingPostalCode);
        System.Assert.areNotEqual(accountsInsertedList[0].ShippingCountry, accountsToUpdateList[0].ShippingCountry);
    }


    
    @IsTest
    static void ffillShippingAddressFields_UpdateAccounts_HasNotAddressFieldChanged() {
        
        //Given
        List<Account> accountsToInsertList = createAccountWithCoordinateLocation(50);
        insert accountsToInsertList;
        List<Account> accountsToUpdateList = accountsToInsertList.clone();

        //When
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new OpenCageGeocoderServiceMock('SUCCESS_CALL'));
            AccountHelper.fillShippingAddressFields(new Map<Id,Account>(accountsToUpdateList), new Map<Id,Account>(accountsToInsertList));
        Test.stopTest();

        //Then
        List<Account> accountsInsertedList = [
            SELECT Id, ShippingStreet, ShippingCity, ShippingState,
                   ShippingPostalCode, ShippingCountry
              FROM Account
             WHERE Name LIKE '%Account Test%'
        ];

        System.Assert.areEqual(50, accountsInsertedList.size());
        System.Assert.areEqual(50, accountsToUpdateList.size());
        System.Assert.areEqual(accountsInsertedList[0].ShippingStreet, accountsToUpdateList[0].ShippingStreet);
        System.Assert.areEqual(accountsInsertedList[0].ShippingCity, accountsToUpdateList[0].ShippingCity);
        System.Assert.areEqual(accountsInsertedList[0].ShippingState, accountsToUpdateList[0].ShippingState);
        System.Assert.areEqual(accountsInsertedList[0].ShippingPostalCode, accountsToUpdateList[0].ShippingPostalCode);
        System.Assert.areEqual(accountsInsertedList[0].ShippingCountry, accountsToUpdateList[0].ShippingCountry);
    } 


    private static List<Account> createAccountWithShippingAddress(Integer quantity) {
        List<Account> accountList = new List<Account>();
    
        for(Integer i = 0; i < quantity; i++) {
            accountList.add(
                new Account (
                    Name                = 'Account Test ' + i,
                    AccountNumber       = '123456'+ i,
                    ShippingStreet      = 'Street Test ' + i,
                    ShippingCity        = 'Burlington', 
                    ShippingState       = 'Burlington',
                    ShippingPostalCode  = '2721'+ i,
                    ShippingCountry     = 'US'
                )
            );
        }

        return accountList;
    }

    private static List<Account> createAccountWithoutShippingAddress(Integer quantity) {
        List<Account> accountList = new List<Account>();
    
        for(Integer i = 0; i < quantity; i++) {
            accountList.add(
                new Account (
                    Name                = 'Account Test ' + i,
                    AccountNumber       = '123456'+ i
                )
            );
        }

        return accountList;
    }

    private static List<Account> createAccountWithCoordinateLocation(Integer quantity) {
        List<Account> accountList = new List<Account>();
    
        for(Integer i = 0; i < quantity; i++) {
            accountList.add(
                new Account (
                    Name                   = 'Account Test ' + i,
                    AccountNumber          = '123456'   + i,
                    Location__latitude__s  = 36.0318    + i,
                    Location__longitude__s = -79.4889   + i
                )
            );
        }

        return accountList;
    }

    

}