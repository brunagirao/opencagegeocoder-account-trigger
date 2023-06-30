/************************************************************************************************
* Name      : OpenCageGeocoder
* Purpose   : Base class to Geocoding API (https://opencagedata.com/api)
* TestClass : OpenCageGeocoderServiceTest
* Author    : Bruna Girão
* Date      : 15-06-2023
***************************************************************************************************/
public class OpenCageGeocoder {

	public Results[] results;
	public Status status;

	public class Results {
		public Annotations annotations;
		public Bounds bounds;
		public Components components;
		public Integer confidence;	//9
		public String formatted;	//Goethe-Nationalmuseum, Frauenplan 1, 99423 Weimar, Germany
		public Geometry geometry;
	}

	public class Annotations {
		public DMS DMS;
		public String MGRS;	//32UPB6346249905
		public String Maidenhead;	//JO50px94ko
		public Mercator Mercator;
		public NUTS NUTS;
		public OSM OSM;
		public UN_M49 UN_M49;
		public Integer callingcode;	//49
		public Money money;
		public String flag;	//🇩🇪
		public String geohash;	//u3041b1jw0trrfc4svjg
		public Double qibla;	//132.4
		public Roadinfo roadinfo;
		public Sun sun;
		public Timezone timezone;
		public What3words what3words;
		public String wikidata;	//Q882721
	}

	public class DMS {
		public String lat;	//50° 58' 39.03816'' N
		public String lng;	//11° 19' 42.75264'' E
	}

	public class Mercator {
		public Double x;	//1261087.577
		public Double y;	//6584100.003
	}

	public class NUTS {
		public NUTS0 NUTS0;
		public NUTS1 NUTS1;
		public NUTS2 NUTS2;
		public NUTS3 NUTS3;
	}

	public class NUTS0 {
		public String code;	//DE
	}
    
	public class NUTS1 {
		public String code;	//DEG
	}

	public class NUTS2 {
		public String code;	//DEG0
	}

	public class NUTS3 {
		public String code;	//DEG05
	}

	public class OSM {
		public String edit_url;	//https://www.openstreetmap.org/edit?relation=3145143#map=16/50.97751/11.32854
		public String note_url;	//https://www.openstreetmap.org/note/new#map=16/50.97751/11.32854&layers=N
		public String url;	//https://www.openstreetmap.org/?mlat=50.97751&mlon=11.32854#map=16/50.97751/11.32854
	}

	public class UN_M49 {
		public Regions regions;
	}

	public class Regions {
		public String DE;	//276
		public String EUROPE;	//150
		public String WESTERN_EUROPE;	//155
		public String WORLD;	//001
	}

	public class Money {
		public AlternateSymbols[] alternate_symbols;
		public String decimal_mark;	//,
		public String html_entity;	//€
		public String iso_code;	//EUR
		public String iso_numeric;	//978
		public String name;	//Euro
		public Integer smallest_denomination;	//1
		public String subunit;	//Cent
		public Integer subunit_to_unit;	//100
		public String symbol;	//€
		public Integer symbol_first;	//0
		public String thousands_separator;	//.
	}

	public class AlternateSymbols {}

	public class Roadinfo {
		public String drive_on;	//right
		public String road;	//Frauenplan
		public String speed_in;	//km/h
	}
    
	public class Sun {
		public Rise rise;
		public GroupSet group_set;
	}

	public class Rise {
		public Integer apparent;	//1686798060
		public Integer astronomical;	//0
		public Integer civil;	//1686795300
		public Integer nautical;	//1686791100
	}

	public class GroupSet{
		public Integer apparent;	//1686857340
		public Integer astronomical;	//0
		public Integer civil;	//1686860160
		public Integer nautical;	//1686864360
	}

	public class Timezone {
		public String name;	//Europe/Berlin
		public Integer now_in_dst;	//1
		public Integer offset_sec;	//7200
		public String offset_string;	//+0200
		public String short_name;	//CEST
	}

	public class What3words {
		public String words;	//rock.broker.partied
	}

	public class Bounds {
		public Northeast northeast;
		public Southwest southwest;
	}

	public class Northeast {
		public Double lat;	//50.9776496
		public Double lng;	//11.328959
	}

	public class Southwest {
		public Double lat;	//50.9773708
		public Double lng;	//11.3284125
	}

	public class Components {
		public String ISO_31661_alpha2;	//DE
		public String ISO_31661_alpha3;	//DEU
		public ISO_31662[] ISO_31662;
		public String category;	//outdoors/recreation
		public String type;	//museum
		public string city; //Swakopmund
		public String continent;	//Europe
		public String country;	//Germany
		public String country_code;	//de
		public String house_number;	//1
		public String museum;	//Goethe-Nationalmuseum
		public String political_union;	//European Union
		public String postcode;	//99423
		public String road;	//Frauenplan
		public String state;	//Thuringia
		public String state_code;	//TH
		public String suburb;	//Altstadt
		public String town;	//Weimar
	}

	public class ISO_31662 {
		public String ISO_31662_0;	//D
		public String ISO_31662_1;	//E
		public String ISO_31662_2;	//-
		public String ISO_31662_3;	//T
		public String ISO_31662_4;	//H
	}

	public class Geometry {
		public Double lat;	//50.9775106
		public Double lng;	//11.3285424
	}

	public class Status {
		public Integer code;	//200
		public String message;	//OK
	}

	public static OpenCageGeocoder parse(String json){
		return (OpenCageGeocoder) System.JSON.deserialize(json, OpenCageGeocoder.class);
	}
}