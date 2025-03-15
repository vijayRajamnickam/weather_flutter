import 'dart:convert';

List<SearchCityNameWithLatAndLon> searchCityNameWithLatAndLonFromJson(String str) {
  List<dynamic> jsonList = json.decode(str);
  return jsonList.map((e) => SearchCityNameWithLatAndLon.fromJson(e)).toList();
}
String searchCityNameWithLatAndLonToJson(SearchCityNameWithLatAndLon data) => json.encode(data.toJson());

class SearchCityNameWithLatAndLon {
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? lat;
  final String? lon;
  final String? placeClass;
  final String? type;
  final int? placeRank;
  final double? importance;
  final String? addresstype;
  final String? name;
  final String? displayName;
  final List<String>? boundingbox;

  SearchCityNameWithLatAndLon({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.placeClass, // Changed from 'class'
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.boundingbox,
  });

  SearchCityNameWithLatAndLon.fromJson(Map<String, dynamic> json)
      : placeId = json['place_id'] as int?,
        licence = json['licence'] as String?,
        osmType = json['osm_type'] as String?,
        osmId = json['osm_id'] as int?,
        lat = json['lat'] as String?,
        lon = json['lon'] as String?,
        placeClass = json['class'] as String?, // Changed from 'class'
        type = json['type'] as String?,
        placeRank = json['place_rank'] as int?,
        importance = json['importance'] as double?,
        addresstype = json['addresstype'] as String?,
        name = json['name'] as String?,
        displayName = json['display_name'] as String?,
        boundingbox = (json['boundingbox'] as List?)
            ?.map((dynamic e) => e as String)
            .toList();

  Map<String, dynamic> toJson() => {
    'place_id': placeId,
    'licence': licence,
    'osm_type': osmType,
    'osm_id': osmId,
    'lat': lat,
    'lon': lon,
    'class': placeClass,
    'type': type,
    'place_rank': placeRank,
    'importance': importance,
    'addresstype': addresstype,
    'name': name,
    'display_name': displayName,
    'boundingbox': boundingbox,
  };
}
