/************************************************************************************************
* Name      : AccountHelper
* Purpose   : Helper class to Account Trigger
* TestClass : AccountHelperTest
* Author    : Bruna Girão
* Date      : 19-06-2023
***************************************************************************************************/
public with sharing class AccountHelper {
    
    /**
    * @description Method responsible to fill the Coordinates fields based on Account Shipping Address
    * @param newRecordsMap 
    * @param oldRecordsMap 
    **/
    public static void fillLocationCoordinatesFields(Map<Id, Account> newRecordsMap, Map<Id, Account> oldRecordsMap) {
        System.debug('======= AccountHelper | fillLocationCoordinatesFields');
        Set<Id> accountIdsSet = new Set<Id>();

        if(oldRecordsMap != null) {

            for(Id accountKey : newRecordsMap.keySet()) {
                Account newAccount = newRecordsMap.get(accountKey);
                Account oldAccount = oldRecordsMap.get(accountKey);

                if(hasAddressFieldsChanged(newAccount, oldAccount)) {
                    accountIdsSet.add(accountKey);
                }
            }

        } else {
            accountIdsSet.addAll(newRecordsMap.keySet());
        }

        if(!accountIdsSet.isEmpty()) {
            OpenCageGeocoderService.getForwardGeoCode(accountIdsSet);
        }

    }

    /**
    * @description Method responsible to fill the Account Shipping Address based on Account Coordinate Fields
    * @param newRecordsMap 
    * @param oldRecordsMap 
    **/
    public static void fillShippingAddressFields(Map<Id, Account> newRecordsMap, Map<Id, Account> oldRecordsMap) {
        System.debug('======= AccountHelper | fillShippingAddressFields');
        Set<Id> accountIdsSet = new Set<Id>();

        if(oldRecordsMap != null) {

            for(Id accountKey : newRecordsMap.keySet()) {
                Account newAccount = newRecordsMap.get(accountKey);
                Account oldAccount = oldRecordsMap.get(accountKey);

                if(hasCoordinatesFieldsChanged(newAccount, oldAccount)) {
                    accountIdsSet.add(accountKey);
                }
            }

        } else {
            accountIdsSet.addAll(newRecordsMap.keySet());
        }

        if(!accountIdsSet.isEmpty()) {
            OpenCageGeocoderService.getReverseGeoCode(accountIdsSet);
        }

    }

    /**
    * @description Method responsible to verify if the Account Shipping Address has changed
    * @param newAccount 
    * @param oldAccount 
    * @return Boolean 
    **/
    private static Boolean hasAddressFieldsChanged(Account newAccount, Account oldAccount) {
        
        return  newAccount.ShippingStreet     != oldAccount.ShippingStreet     ||
                newAccount.ShippingCity       != oldAccount.ShippingCity       ||
                newAccount.ShippingState      != oldAccount.ShippingState      ||
                newAccount.ShippingPostalCode != oldAccount.ShippingPostalCode ||
                newAccount.ShippingCountry    != oldAccount.ShippingCountry;
    }

    /**
    * @description Method responsible to verify if the Account Coordinate fields has changed
    * @param newAccount 
    * @param oldAccount 
    * @return Boolean 
    **/
    private static Boolean hasCoordinatesFieldsChanged(Account newAccount, Account oldAccount) {
        return  newAccount.Location__latitude__s  != oldAccount.Location__latitude__s     ||
                newAccount.Location__longitude__s != oldAccount.Location__longitude__s;
    }
}