/************************************************************************************************
* Name      : OpenCageGeocoderService
* Purpose   : Class to get Location Info from OpenCageData API (https://opencagedata.com/api)
* TestClass : OpenCageGeocoderServiceTest
* Author    : Bruna Girão
* Date      : 15-06-2023
***************************************************************************************************/
public with sharing class OpenCageGeocoderService {

    //OpenCageGeocoder Custom Settings
    public static OpenCageGeocoder_Settings__c openGeocoderSettings = OpenCageGeocoder_Settings__c.getInstance('Default');

    //HTTP Request/Response Varaibles
    public static Http http;            
    public static HttpRequest request; 
    public static HttpResponse response;

    public static void getForwardGeoCode(Set<Id> recordIdSet) {
        System.debug('OpenCageGeocoderServide | getForwardGeoCode');
        System.debug('recordIdSet=> ' + recordIdSet);

        try {
            // Get Account records based on recordIdSet
            List<Account> accountsToUpdate = getAccountsToUpdateCoordinates(recordIdSet);
            System.debug('accountsToUpdate => ' + accountsToUpdate);

            if(!accountsToUpdate.isEmpty()) {

                //Start HTTP Request/Response variables
                http     = new Http();
                request  = new HttpRequest();
                response = new HttpResponse();

                //Build base URL Params for Request
                Map<String, String> baseURLParamMap = getBaseURLParam();    
                
                for (Account acc : accountsToUpdate) {

                    //Build dynamic query part of the endpoint getting data address information
                    baseURLParamMap.put(
                                    'query',
                                    'q='+ EncodingUtil.urlEncode( 
                                          acc.ShippingAddress.getStreet()     + ',' 
                                        + acc.ShippingAddress.getCity()       + ',' 
                                        + acc.ShippingAddress.getState()      + ',' 
                                        + acc.ShippingAddress.getPostalCode() + ',' 
                                        + acc.ShippingAddress.getCountry(),
                                            'UTF-8'
                                    )
                    );
                    System.debug('baseURLParamMap => ' + baseURLParamMap);

                    response = http.send(createBaseRequest(baseURLParamMap));
                    
                    if(response.getStatusCode() >= 200 && response.getStatusCode() < 300) {

                        OpenCageGeocoder openCageGeocoderData = (OpenCageGeocoder)JSON.deserialize(response.getBody(), OpenCageGeocoder.class);
                        List<OpenCageGeocoder.Results> openCageGeocoderDataResults = (List<OpenCageGeocoder.Results>) openCageGeocoderData.results;
        
                        if(!openCageGeocoderDataResults.isEmpty()) {
        
                            OpenCageGeocoder.Results openCageGeocoderDataResult = openCageGeocoderDataResults.get(0);
                            acc.Location__latitude__s  = openCageGeocoderDataResult.geometry.lat;
                            acc.Location__longitude__s = openCageGeocoderDataResult.geometry.lng;
                            acc.Location_Link__c       = openCageGeocoderDataResult.annotations.OSM.url;
                        }
                    } else {
                        System.debug('ERROR=>' + response.getBody());
                    }
                }

                SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, accountsToUpdate);
                System.debug('decision.getRecords() => ' + decision.getRecords());
                update decision.getRecords();
            }

        } catch (Exception e) {
            System.debug('ERROR => ' + e.getStackTraceString());
        }

    }

    @future (callout=true)
    public static void getReverseGeoCode(Set<Id> recordIdsSet) {
        System.debug('OpenCageGeocoderService | GetReverseGeoCode ');
        System.debug('recordIdsSet => ' + recordIdsSet);

        try {
            List<Account> accountsToUpdate = getAccountsToUpdateAddress(recordIdsSet);
            System.debug('accountsToUpdate => ' + accountsToUpdate);

            if(!accountsToUpdate.isEmpty()) {

                //Start HTTP Request/Response variables
                http     = new Http();
                request  = new HttpRequest();
                response = new HttpResponse();

                //Build base URL Params for Request
                Map<String, String> baseURLParamMap = getBaseURLParam();    
                
                for (Account acc : accountsToUpdate) {

                    //Build dynamic query part of the endpoint getting lat/long information
                    baseURLParamMap.put(
                                    'query',
                                    'q='+ EncodingUtil.urlEncode( 
                                          acc.Location__latitude__s  + ',' 
                                        + acc.Location__longitude__s + ',',
                                          'UTF-8'
                                    )
                    );
                    System.debug('baseURLParamMap => ' + baseURLParamMap);

                    response = http.send(createBaseRequest(baseURLParamMap));
                    
                    if(response.getStatusCode() >= 200 && response.getStatusCode() < 300) {

                        OpenCageGeocoder openCageGeocoderData = (OpenCageGeocoder)JSON.deserialize(response.getBody(), OpenCageGeocoder.class);
                        List<OpenCageGeocoder.Results> openCageGeocoderDataResults = (List<OpenCageGeocoder.Results>) openCageGeocoderData.results;
        
                        if(!openCageGeocoderDataResults.isEmpty()) {
        
                            OpenCageGeocoder.Results openCageGeocoderDataResult = openCageGeocoderDataResults.get(0);
                            acc.ShippingStreet     = openCageGeocoderDataResult.components.road;
                            acc.ShippingCity       = openCageGeocoderDataResult.components.city;
                            acc.ShippingState      = openCageGeocoderDataResult.components.state;
                            acc.ShippingPostalCode = openCageGeocoderDataResult.components.postcode;
                            acc.ShippingCountry    = openCageGeocoderDataResult.components.country_code;
                            acc.Location_Link__c   = openCageGeocoderDataResult.annotations.OSM.url;
                        }
                    } else {
                        System.debug('ERROR=>' + response.getBody());
                    }
                }

                SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, accountsToUpdate);
                System.debug('decision.getRecords() => ' + decision.getRecords());
                update decision.getRecords();
            }

        } catch (Exception e) {
            System.debug('ERROR=>' + e.getStackTraceString());
        }
    }


    /**
    * @description Method responsible to create the Base request.
    * @param requestParamsMap 
    * @return HttpRequest 
    **/
    private static HttpRequest createBaseRequest(Map<String, String> requestParamsMap) {
        request.setEndpoint('callout:GetOpenCageGeocoderData' + 
                                openGeocoderSettings.Endpoint__c + 
                                requestParamsMap.get('query')     + '&' + 
                                requestParamsMap.get('key')       + '&' + 
                                requestParamsMap.get('pretty')    + '&' +
                                requestParamsMap.get('limit')
                            );
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        return request;
    }

    /**
    * @description Method responsible for get URL param to build the endpoint request.
    * @param acc 
    * @return Map<String, String> 
    **/
    private static Map<String, String> getBaseURLParam() {
        Map<String, String> urlParamsMap = new Map <String, String> {
            'key'    => 'key=' + openGeocoderSettings.ApiKey__c, 
            'pretty' => 'pretty=1',
            'limit'  => 'limit=1'
        };

        return urlParamsMap;
    }


    /**
    * @description Method responsible for return Accounts records with valid 
                   Shipping Address to update Location Coordinates (lat/long)
    * @param recordIdsSet 
    * @return List<Account> 
    **/
    private static List<Account> getAccountsToUpdateCoordinates(Set<Id> recordIdsSet) {

        return [SELECT Id, Location__latitude__s, Location_Link__c,
                       Location__longitude__s, ShippingAddress
                  FROM Account
                 WHERE Id =: recordIdsSet
                   AND ShippingStreet      != '' 
                   AND ShippingCity        != '' 
                   AND ShippingState       != '' 
                   AND ShippingPostalCode  != '' 
                   AND ShippingCountry     != '' 
                ];
    }

     /**
    * @description Method responsible for return Accounts record with valid 
                   Location Coordinates to update Shipping Address
    * @param recordIdsSet 
    * @return List<Account> 
    **/
    private static List<Account> getAccountsToUpdateAddress(Set<Id> recordIdsSet) {

        return [SELECT Id, Location__latitude__s, Location_Link__c,
                       Location__longitude__s, ShippingAddress
                  FROM Account
                 WHERE Id =: recordIdsSet
                  WITH SECURITY_ENFORCED
                ];
    }
}