class ModelWeather {
  String? cod = '';
  int? message = 0;
  int? cnt = 0;
  List<ModelWeatherList>? list;
  ModelWeatherCity? city;

  ModelWeather({this.cod = '', this.message = 0, this.cnt = 0, this.list, this.city});

  ModelWeather.fromJson(Map<String, dynamic> json) {
    cod = json["cod"].toString();
    message = json["message"];
    cnt = json["cnt"];
    list = json["list"] == null ? [] : (json["list"] as List).map((e) => ModelWeatherList.fromJson(e)).toList();
    city = json["city"] == null ? null : ModelWeatherCity.fromJson(json["city"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["cod"] = cod;
    data["message"] = message;
    data["cnt"] = cnt;
    if (list != null) {
      data["list"] = list?.map((e) => e.toJson()).toList();
    }
    if (city != null) {
      data["city"] = city?.toJson();
    }
    return data;
  }
}

class ModelWeatherCity {
  int? id = 0;
  String? name = '';
  ModelWeatherCityCoord? coord;
  String? country = '';
  int? population = 0;
  int? timezone = 0;
  int? sunrise = 0;
  int? sunset = 0;

  ModelWeatherCity({
    this.id = 0,
    this.name = '',
    this.coord,
    this.country = '',
    this.population = 0,
    this.timezone = 0,
    this.sunrise = 0,
    this.sunset = 0,
  });

  ModelWeatherCity.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"].toString();
    coord = json["coord"] == null ? null : ModelWeatherCityCoord.fromJson(json["coord"]);
    country = json["country"].toString();
    population = json["population"];
    timezone = json["timezone"];
    sunrise = json["sunrise"];
    sunset = json["sunset"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    if (coord != null) {
      data["coord"] = coord?.toJson();
    }
    data["country"] = country;
    data["population"] = population;
    data["timezone"] = timezone;
    data["sunrise"] = sunrise;
    data["sunset"] = sunset;
    return data;
  }
}

class ModelWeatherCityCoord {
  double? lat = 0.0;
  double? lon = 0.0;

  ModelWeatherCityCoord({this.lat, this.lon});

  ModelWeatherCityCoord.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    lon = json["lon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["lat"] = lat;
    data["lon"] = lon;
    return data;
  }
}

class ModelWeatherList {
  int? dt = 0;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility = 0;
  int? pop = 0;
  Sys? sys;
  String? dtTxt = '';

  ModelWeatherList({
    this.dt = 0,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility = 0,
    this.pop = 0,
    this.sys,
    this.dtTxt = '',
  });

  ModelWeatherList.fromJson(Map<String, dynamic> json) {
    dt = json["dt"];
    main = json["main"] == null ? null : Main.fromJson(json["main"]);
    weather = json["weather"] == null ? null : (json["weather"] as List).map((e) => Weather.fromJson(e)).toList();
    clouds = json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]);
    wind = json["wind"] == null ? null : Wind.fromJson(json["wind"]);
    visibility = json["visibility"];
    pop = json["pop"];
    sys = json["sys"] == null ? null : Sys.fromJson(json["sys"]);
    dtTxt = json["dt_txt"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["dt"] = dt;
    if (main != null) {
      data["main"] = main?.toJson();
    }
    if (weather != null) {
      data["weather"] = weather?.map((e) => e.toJson()).toList();
    }
    if (clouds != null) {
      data["clouds"] = clouds?.toJson();
    }
    if (wind != null) {
      data["wind"] = wind?.toJson();
    }
    data["visibility"] = visibility;
    data["pop"] = pop;
    if (sys != null) {
      data["sys"] = sys?.toJson();
    }
    data["dt_txt"] = dtTxt;
    return data;
  }
}

class Sys {
  String? pod = '';

  Sys({this.pod = ''});

  Sys.fromJson(Map<String, dynamic> json) {
    pod = json["pod"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["pod"] = pod;
    return data;
  }
}

class Wind {
  dynamic speed;
  int? deg = 0;
  dynamic gust;

  Wind({this.speed, this.deg = 0, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json["speed"];
    deg = json["deg"];
    gust = json["gust"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["speed"] = speed;
    data["deg"] = deg;
    data["gust"] = gust;
    return data;
  }
}

class Clouds {
  int? all = 0;

  Clouds({this.all = 0});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json["all"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["all"] = all;
    return data;
  }
}

class Weather {
  int? id = 0;
  String? main = '';
  String? description = '';
  String? icon = '';

  Weather({
    this.id = 0,
    this.main = '',
    this.description = '',
    this.icon = '',
  });

  Weather.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    main = json["main"].toString();
    description = json["description"].toString();
    icon = json["icon"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["main"] = main;
    data["description"] = description;
    data["icon"] = icon;
    return data;
  }
}

class Main {
  dynamic temp;
  dynamic feelsLike;
  dynamic tempMin;
  dynamic tempMax;
  int? pressure = 0;
  int? seaLevel = 0;
  int? grndLevel = 0;
  int? humidity = 0;
  dynamic tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure = 0,
    this.seaLevel = 0,
    this.grndLevel = 0,
    this.humidity = 0,
    this.tempKf,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = json["temp"];
    feelsLike = json["feels_like"];
    tempMin = json["temp_min"];
    tempMax = json["temp_max"];
    pressure = json["pressure"];
    seaLevel = json["sea_level"];
    grndLevel = json["grnd_level"];
    humidity = json["humidity"];
    tempKf = json["temp_kf"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["temp"] = temp;
    data["feels_like"] = feelsLike;
    data["temp_min"] = tempMin;
    data["temp_max"] = tempMax;
    data["pressure"] = pressure;
    data["sea_level"] = seaLevel;
    data["grnd_level"] = grndLevel;
    data["humidity"] = humidity;
    data["temp_kf"] = tempKf;
    return data;
  }
}
