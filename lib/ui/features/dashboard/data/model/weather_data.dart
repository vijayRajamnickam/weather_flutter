import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final dynamic visibility;
  final Wind? wind;
  final Rain? rain;
  final Clouds? clouds;
  final dynamic dt;
  final Sys? sys;
  final dynamic timezone;
  final dynamic id;
  final String? name;
  final dynamic cod;

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
    : coord =
          (json['coord'] as Map<String, dynamic>?) != null
              ? Coord.fromJson(json['coord'] as Map<String, dynamic>)
              : null,
      weather =
          (json['weather'] as List?)
              ?.map((dynamic e) => Weather.fromJson(e as Map<String, dynamic>))
              .toList(),
      base = json['base'] as String?,
      main =
          (json['main'] as Map<String, dynamic>?) != null
              ? Main.fromJson(json['main'] as Map<String, dynamic>)
              : null,
      visibility = json['visibility'] as dynamic,
      wind =
          (json['wind'] as Map<String, dynamic>?) != null
              ? Wind.fromJson(json['wind'] as Map<String, dynamic>)
              : null,
      rain =
          (json['rain'] as Map<String, dynamic>?) != null
              ? Rain.fromJson(json['rain'] as Map<String, dynamic>)
              : null,
      clouds =
          (json['clouds'] as Map<String, dynamic>?) != null
              ? Clouds.fromJson(json['clouds'] as Map<String, dynamic>)
              : null,
      dt = json['dt'] as dynamic,
      sys =
          (json['sys'] as Map<String, dynamic>?) != null
              ? Sys.fromJson(json['sys'] as Map<String, dynamic>)
              : null,
      timezone = json['timezone'] as dynamic,
      id = json['id'] as dynamic,
      name = json['name'] as String?,
      cod = json['cod'] as dynamic;

  Map<String, dynamic> toJson() => {
    'coord': coord?.toJson(),
    'weather': weather?.map((e) => e.toJson()).toList(),
    'base': base,
    'main': main?.toJson(),
    'visibility': visibility,
    'wind': wind?.toJson(),
    'rain': rain?.toJson(),
    'clouds': clouds?.toJson(),
    'dt': dt,
    'sys': sys?.toJson(),
    'timezone': timezone,
    'id': id,
    'name': name,
    'cod': cod,
  };
}

class Coord {
  final dynamic lon;
  final dynamic lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json)
    : lon = json['lon'] as dynamic,
      lat = json['lat'] as dynamic;

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};
}

class Weather {
  final dynamic id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json)
    : id = json['id'] as dynamic,
      main = json['main'] as String?,
      description = json['description'] as String?,
      icon = json['icon'] as String?;

  Map<String, dynamic> toJson() => {
    'id': id,
    'main': main,
    'description': description,
    'icon': icon,
  };
}

class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final dynamic pressure;
  final dynamic humidity;
  final dynamic seaLevel;
  final dynamic grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  Main.fromJson(Map<String, dynamic> json)
    : temp = json['temp'] as double?,
      feelsLike = json['feels_like'] as double?,
      tempMin = json['temp_min'] as double?,
      tempMax = json['temp_max'] as double?,
      pressure = json['pressure'] as dynamic,
      humidity = json['humidity'] as dynamic,
      seaLevel = json['sea_level'] as dynamic,
      grndLevel = json['grnd_level'] as dynamic;

  Map<String, dynamic> toJson() => {
    'temp': temp,
    'feels_like': feelsLike,
    'temp_min': tempMin,
    'temp_max': tempMax,
    'pressure': pressure,
    'humidity': humidity,
    'sea_level': seaLevel,
    'grnd_level': grndLevel,
  };
}

class Wind {
  final double? speed;
  final dynamic deg;
  final double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json)
    : speed = json['speed'] as double?,
      deg = json['deg'] as dynamic,
      gust = json['gust'] as double?;

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};
}

class Rain {
  final double? value;

  Rain({this.value});

  Rain.fromJson(Map<String, dynamic> json) : value = json['1h'] as double?;

  Map<String, dynamic> toJson() => {'value': value};
}

class Clouds {
  final dynamic all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) : all = json['all'] as dynamic;

  Map<String, dynamic> toJson() => {'all': all};
}

class Sys {
  final String? country;
  final dynamic sunrise;
  final dynamic sunset;

  Sys({this.country, this.sunrise, this.sunset});

  Sys.fromJson(Map<String, dynamic> json)
    : country = json['country'] as String?,
      sunrise = json['sunrise'] as dynamic,
      sunset = json['sunset'] as dynamic;

  Map<String, dynamic> toJson() => {
    'country': country,
    'sunrise': sunrise,
    'sunset': sunset,
  };
}
