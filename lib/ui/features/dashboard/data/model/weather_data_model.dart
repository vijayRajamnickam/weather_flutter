

import 'dart:convert';

WeatherDataModel weatherDataModelFromJson(String str) =>
    WeatherDataModel.fromJson(json.decode(str));

String weatherDataModelToJson(WeatherDataModel data) =>
    json.encode(data.toJson());

class WeatherDataModel {
  final dynamic lat;
  final dynamic lon;
  final String? timezone;
  final dynamic timezoneOffset;
  final Current? current;
  final List<Minutely>? minutely;
  final List<Hourly>? hourly;
  final List<Daily>? daily;

  WeatherDataModel({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.minutely,
    this.hourly,
    this.daily,
  });

  WeatherDataModel.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as dynamic,
        lon = json['lon'] as dynamic,
        timezone = json['timezone'] as String?,
        timezoneOffset = json['timezone_offset'] as dynamic,
        current = (json['current'] as Map<String,dynamic>?) != null ? Current.fromJson(json['current'] as Map<String,dynamic>) : null,
        minutely = (json['minutely'] as List?)?.map((dynamic e) => Minutely.fromJson(e as Map<String,dynamic>)).toList(),
        hourly = (json['hourly'] as List?)?.map((dynamic e) => Hourly.fromJson(e as Map<String,dynamic>)).toList(),
        daily = (json['daily'] as List?)?.map((dynamic e) => Daily.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'lat' : lat,
    'lon' : lon,
    'timezone' : timezone,
    'timezone_offset' : timezoneOffset,
    'current' : current?.toJson(),
    'minutely' : minutely?.map((e) => e.toJson()).toList(),
    'hourly' : hourly?.map((e) => e.toJson()).toList(),
    'daily' : daily?.map((e) => e.toJson()).toList()
  };
}

class Current {
  final dynamic dt;
  final dynamic sunrise;
  final dynamic sunset;
  final dynamic temp;
  final dynamic feelsLike;
  final dynamic pressure;
  final dynamic humidity;
  final dynamic dewPoint;
  final dynamic uvi;
  final dynamic clouds;
  final dynamic visibility;
  final dynamic windSpeed;
  final dynamic windDeg;
  final dynamic windGust;
  final List<Weather>? weather;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
  });

  Current.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] as dynamic,
        sunrise = json['sunrise'] as dynamic,
        sunset = json['sunset'] as dynamic,
        temp = json['temp'] as dynamic,
        feelsLike = json['feels_like'] as dynamic,
        pressure = json['pressure'] as dynamic,
        humidity = json['humidity'] as dynamic,
        dewPoint = json['dew_point'] as dynamic,
        uvi = json['uvi'] as dynamic,
        clouds = json['clouds'] as dynamic,
        visibility = json['visibility'] as dynamic,
        windSpeed = json['wind_speed'] as dynamic,
        windDeg = json['wind_deg'] as dynamic,
        windGust = json['wind_gust'] as dynamic,
        weather = (json['weather'] as List?)?.map((dynamic e) => Weather.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'dt' : dt,
    'sunrise' : sunrise,
    'sunset' : sunset,
    'temp' : temp,
    'feels_like' : feelsLike,
    'pressure' : pressure,
    'humidity' : humidity,
    'dew_point' : dewPoint,
    'uvi' : uvi,
    'clouds' : clouds,
    'visibility' : visibility,
    'wind_speed' : windSpeed,
    'wind_deg' : windDeg,
    'wind_gust' : windGust,
    'weather' : weather?.map((e) => e.toJson()).toList()
  };
}

class Minutely {
  final dynamic dt;
  final dynamic precipitation;

  Minutely({
    this.dt,
    this.precipitation,
  });

  Minutely.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] as dynamic,
        precipitation = json['precipitation'] as dynamic;

  Map<String, dynamic> toJson() => {
    'dt' : dt,
    'precipitation' : precipitation
  };
}

class Hourly {
  final dynamic dt;
  final dynamic temp;
  final dynamic feelsLike;
  final dynamic pressure;
  final dynamic humidity;
  final dynamic dewPoint;
  final dynamic uvi;
  final dynamic clouds;
  final dynamic visibility;
  final dynamic windSpeed;
  final dynamic windDeg;
  final dynamic windGust;
  final List<Weather>? weather;
  final dynamic pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  Hourly.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] as dynamic,
        temp = json['temp'] as dynamic,
        feelsLike = json['feels_like'] as dynamic,
        pressure = json['pressure'] as dynamic,
        humidity = json['humidity'] as dynamic,
        dewPoint = json['dew_point'] as dynamic,
        uvi = json['uvi'] as dynamic,
        clouds = json['clouds'] as dynamic,
        visibility = json['visibility'] as dynamic,
        windSpeed = json['wind_speed'] as dynamic,
        windDeg = json['wind_deg'] as dynamic,
        windGust = json['wind_gust'] as dynamic,
        weather = (json['weather'] as List?)?.map((dynamic e) => Weather.fromJson(e as Map<String,dynamic>)).toList(),
        pop = json['pop'] as dynamic;

  Map<String, dynamic> toJson() => {
    'dt' : dt,
    'temp' : temp,
    'feels_like' : feelsLike,
    'pressure' : pressure,
    'humidity' : humidity,
    'dew_point' : dewPoint,
    'uvi' : uvi,
    'clouds' : clouds,
    'visibility' : visibility,
    'wind_speed' : windSpeed,
    'wind_deg' : windDeg,
    'wind_gust' : windGust,
    'weather' : weather?.map((e) => e.toJson()).toList(),
    'pop' : pop
  };
}

class Weather {
  final dynamic id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json)
      : id = json['id'] as dynamic,
        main = json['main'] as String?,
        description = json['description'] as String?,
        icon = json['icon'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'main' : main,
    'description' : description,
    'icon' : icon
  };
}

class Daily {
  final dynamic dt;
  final dynamic sunrise;
  final dynamic sunset;
  final dynamic moonrise;
  final dynamic moonset;
  final dynamic moonPhase;
  final String? summary;
  final Temp? temp;
  final FeelsLike? feelsLike;
  final dynamic pressure;
  final dynamic humidity;
  final dynamic dewPoint;
  final dynamic windSpeed;
  final dynamic windDeg;
  final dynamic windGust;
  final List<Weather>? weather;
  final dynamic clouds;
  final dynamic pop;
  final dynamic rain;
  final dynamic uvi;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.summary,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.uvi,
  });

  Daily.fromJson(Map<String, dynamic> json)
      : dt = json['dt'] as dynamic,
        sunrise = json['sunrise'] as dynamic,
        sunset = json['sunset'] as dynamic,
        moonrise = json['moonrise'] as dynamic,
        moonset = json['moonset'] as dynamic,
        moonPhase = json['moon_phase'] as dynamic,
        summary = json['summary'] as String?,
        temp = (json['temp'] as Map<String,dynamic>?) != null ? Temp.fromJson(json['temp'] as Map<String,dynamic>) : null,
        feelsLike = (json['feels_like'] as Map<String,dynamic>?) != null ? FeelsLike.fromJson(json['feels_like'] as Map<String,dynamic>) : null,
        pressure = json['pressure'] as dynamic,
        humidity = json['humidity'] as dynamic,
        dewPoint = json['dew_point'] as dynamic,
        windSpeed = json['wind_speed'] as dynamic,
        windDeg = json['wind_deg'] as dynamic,
        windGust = json['wind_gust'] as dynamic,
        weather = (json['weather'] as List).map((dynamic e) => Weather.fromJson(e as Map<String,dynamic>)).toList(),
        clouds = json['clouds'] as dynamic,
        pop = json['pop'] as dynamic,
        rain = json['rain'] as dynamic,
        uvi = json['uvi'] as dynamic;

  Map<String, dynamic> toJson() => {
    'dt' : dt,
    'sunrise' : sunrise,
    'sunset' : sunset,
    'moonrise' : moonrise,
    'moonset' : moonset,
    'moon_phase' : moonPhase,
    'summary' : summary,
    'temp' : temp?.toJson(),
    'feels_like' : feelsLike?.toJson(),
    'pressure' : pressure,
    'humidity' : humidity,
    'dew_point' : dewPoint,
    'wind_speed' : windSpeed,
    'wind_deg' : windDeg,
    'wind_gust' : windGust,
    'weather' : weather?.map((e) => e.toJson()).toList(),
    'clouds' : clouds,
    'pop' : pop,
    'rain' : rain,
    'uvi' : uvi
  };
}

class Temp {
  final dynamic day;
  final dynamic min;
  final dynamic max;
  final dynamic night;
  final dynamic eve;
  final dynamic morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  Temp.fromJson(Map<String, dynamic> json)
      : day = json['day'] as dynamic,
        min = json['min'] as dynamic,
        max = json['max'] as dynamic,
        night = json['night'] as dynamic,
        eve = json['eve'] as dynamic,
        morn = json['morn'] as dynamic;

  Map<String, dynamic> toJson() => {
    'day' : day,
    'min' : min,
    'max' : max,
    'night' : night,
    'eve' : eve,
    'morn' : morn
  };
}

class FeelsLike {
  final dynamic day;
  final dynamic night;
  final dynamic eve;
  final dynamic morn;

  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  FeelsLike.fromJson(Map<String, dynamic> json)
      : day = json['day'] as dynamic,
        night = json['night'] as dynamic,
        eve = json['eve'] as dynamic,
        morn = json['morn'] as dynamic;

  Map<String, dynamic> toJson() => {
    'day' : day,
    'night' : night,
    'eve' : eve,
    'morn' : morn
  };
}



