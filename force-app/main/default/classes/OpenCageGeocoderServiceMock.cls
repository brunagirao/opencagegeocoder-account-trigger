/************************************************************************************************
* Name      : OpenCageGeocoderServiceMock
* Purpose   : Mock class class to OpenCageGeocoderService
* TestClass : OpenCageGeocoderServiceTest
* Author    : Bruna Girão
* Date      : 19-06-2023
***************************************************************************************************/
@IsTest
global without sharing class OpenCageGeocoderServiceMock implements HttpCalloutMock {
    private String responseType;
	private Integer httpCode;

	public OpenCageGeocoderServiceMock(String responseType){
		this.responseType = responseType;
	}
	public OpenCageGeocoderServiceMock(Integer httpCode){
		this.httpCode = httpCode;
	}

	public HttpResponse respond(HttpRequest req){
		HttpResponse response = new HttpResponse();

		if (httpCode != null){
			if(httpCode == 400){
				response.setStatus('ERROR');
				response.setStatusCode(httpCode);
				response.setHeader('Content-Type', 'application/json; charset=utf-8');
				response.setBody(getErrorCall());
				return response;
			}
			else{
				response.setStatus('ERROR');
				response.setStatusCode(httpCode);
				response.setHeader('Content-size', '0');
				return response;
			}
		}
		else{
			response.setStatus('OK');
			response.setStatusCode(200);
			response.setHeader('Content-Type', 'application/json; charset=utf-8');
			response.setBody(getCorrectPayload());
			return response;
		}
	}

	private String getCorrectPayload(){
		switch on responseType {
			when 'SUCCESS_CALL'{
				return getSuccessfulCall();
			}

			when 'ERROR_CALL'{
				return getErrorCall();
			}
		}

		return '';
	}

	private String getSuccessfulCall(){
		return ('{'+
		'    "results": ['+
		'        {'+
		'            "annotations": {'+
		'                "DMS": {'+
		'                    "lat": "36° 1' + '54.48000' + ' N",'+
		'                    "lng": "79° 29' + '20.04000' + ' W"'+
		'                },'+
		'                "FIPS": {'+
		'                    "county": "37001",'+
		'                    "state": "37"'+
		'                },'+
		'                "MGRS": "17SPV3614288531",'+
		'                "Maidenhead": "FM06ga17hp",'+
		'                "Mercator": {'+
		'                    "x": -8848663.872,'+
		'                    "y": 4279862.235'+
		'                },'+
		'                "OSM": {'+
		'                    "note_url": "https://www.openstreetmap.org/note/new#map=17/36.03180/-79.48890&layers=N",'+
		'                    "url": "https://www.openstreetmap.org/?mlat=36.03180&mlon=-79.48890#map=17/36.03180/-79.48890"'+
		'                },'+
		'                "UN_M49": {'+
		'                    "regions": {'+
		'                        "AMERICAS": "019",'+
		'                        "NORTHERN_AMERICA": "021",'+
		'                        "US": "840",'+
		'                        "WORLD": "001"'+
		'                    },'+
		'                    "statistical_groupings": ['+
		'                        "MEDC"'+
		'                    ]'+
		'                },'+
		'                "callingcode": 1,'+
		'                "currency": {'+
		'                    "alternate_symbols": ['+
		'                        "US$"'+
		'                    ],'+
		'                    "decimal_mark": ".",'+
		'                    "disambiguate_symbol": "US$",'+
		'                    "html_entity": "$",'+
		'                    "iso_code": "USD",'+
		'                    "iso_numeric": "840",'+
		'                    "name": "United States Dollar",'+
		'                    "smallest_denomination": 1,'+
		'                    "subunit": "Cent",'+
		'                    "subunit_to_unit": 100,'+
		'                    "symbol": "$",'+
		'                    "symbol_first": 1,'+
		'                    "thousands_separator": ","'+
		'                },'+
		'                "flag": "🇺🇸",'+
		'                "geohash": "dnrkzpmuqqk5pnpcryj6",'+
		'                "qibla": 55.23,'+
		'                "roadinfo": {'+
		'                    "drive_on": "right",'+
		'                    "speed_in": "mph"'+
		'                },'+
		'                "sun": {'+
		'                    "rise": {'+
		'                        "apparent": 1687773840,'+
		'                        "astronomical": 1687767300,'+
		'                        "civil": 1687772040,'+
		'                        "nautical": 1687769760'+
		'                    },'+
		'                    "set": {'+
		'                        "apparent": 1687739880,'+
		'                        "astronomical": 1687746420,'+
		'                        "civil": 1687741680,'+
		'                        "nautical": 1687743900'+
		'                    }'+
		'                },'+
		'                "timezone": {'+
		'                    "name": "America/New_York",'+
		'                    "now_in_dst": 1,'+
		'                    "offset_sec": -14400,'+
		'                    "offset_string": "-0400",'+
		'                    "short_name": "EDT"'+
		'                },'+
		'                "what3words": {'+
		'                    "words": "tombstone.deleted.shillings"'+
		'                }'+
		'            },'+
		'            "bounds": {'+
		'                "northeast": {'+
		'                    "lat": 36.112233,'+
		'                    "lng": -79.413041'+
		'                },'+
		'                "southwest": {'+
		'                    "lat": 35.944193,'+
		'                    "lng": -79.585332'+
		'                }'+
		'            },'+
		'            "components": {'+
		'                "ISO_3166-1_alpha-2": "US",'+
		'                "ISO_3166-1_alpha-3": "USA",'+
		'                "ISO_3166-2": ['+
		'                    "US-NC"'+
		'                ],'+
		'                "_category": "postcode",'+
		'                "_type": "postcode",'+
		'                "continent": "North America",'+
		'				 "city": "Burlington",'+
		'                "country": "United States of America",'+
		'                "country_code": "US",'+
		'                "county": "Alamance County",'+
		'                "postcode": "27215",'+
		'                "state": "North Carolina",'+
		'                "road": "South Lexington Avenue",'+
		'                "state_code": "NC"'+
		'            },'+
		'            "confidence": 7,'+
		'            "formatted": "Alamance County, NC 27215, United States of America",'+
		'            "geometry": {'+
		'                "lat": 36.0318,'+
		'                "lng": -79.4889'+
		'            }'+
		'        }'+
		'    ],'+
		'    "status": {'+
		'        "code": 200,'+
		'        "message": "OK"'+
		'    }'+
		'}');
	}


	private String getErrorCall(){
		return ('{'+
                    '"results": "[]",'+
					'"status": {'+
					' 	"code": 401,'+
					' 	"message": "missing API key"'+
					' }'+
					'"total_results": 0' +
                '}');
	}
}