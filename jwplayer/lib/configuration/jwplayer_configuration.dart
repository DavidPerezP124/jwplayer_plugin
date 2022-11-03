// To parse this JSON data, do
//
//     final jwPlayerConfiguration = jwPlayerConfigurationFromMap(jsonString);

import 'dart:convert';

class JWPlayerConfiguration {
  JWPlayerConfiguration({
    this.file,
    this.playlist,
    this.tracks,
    this.sources,
    this.image,
    this.autostart,
    this.analytics,
    this.related,
    this.advertising,
  });

  String? file;
  bool? autostart;
  List<PlaylistItem>? playlist;
  List<Track>? tracks;
  List<Source>? sources;
  String? image;
  Analytics? analytics;
  Related? related;
  Advertising? advertising;

  JWPlayerConfiguration copyWith({
    String? file,
    List<PlaylistItem>? playlist,
    List<Track>? tracks,
    List<Source>? sources,
    String? image,
    bool? autostart,
    Analytics? analytics,
    Related? related,
    Advertising? advertising,
  }) =>
      JWPlayerConfiguration(
        file: file ?? this.file,
        playlist: playlist ?? this.playlist,
        tracks: tracks ?? this.tracks,
        sources: sources ?? this.sources,
        image: image ?? this.image,
        autostart: autostart ?? this.autostart,
        analytics: analytics ?? this.analytics,
        related: related ?? this.related,
        advertising: advertising ?? this.advertising,
      );

  factory JWPlayerConfiguration.fromJson(String str) =>
      JWPlayerConfiguration.fromMap(json.decode(str));

  static JWPlayerConfiguration empty = JWPlayerConfiguration();

  String toJson() => json.encode(toMap());

  factory JWPlayerConfiguration.fromMap(Map<String, dynamic> json) =>
      JWPlayerConfiguration(
        file: json["file"],
        autostart: json["autostart"],
        playlist: json["playlist"] == null
            ? null
            : List<PlaylistItem>.from(
                json["playlist"].map((x) => PlaylistItem.fromMap(x))),
        tracks: json["tracks"] == null
            ? null
            : List<Track>.from(json["tracks"].map((x) => Track.fromMap(x))),
        sources: json["sources"] == null
            ? null
            : List<Source>.from(json["sources"].map((x) => Source.fromMap(x))),
        image: json["image"],
        analytics: json["analytics"] == null
            ? null
            : Analytics.fromMap(json["analytics"]),
        related:
            json["related"] == null ? null : Related.fromMap(json["related"]),
        advertising: json["advertising"] == null
            ? null
            : Advertising.fromMap(json["advertising"]),
      );

  Map<String, dynamic> toMap() => {
        "file": file,
        "autostart": autostart,
        "playlist": playlist == null
            ? null
            : List<dynamic>.from(playlist!.map((x) => x.toMap())),
        "tracks": tracks == null
            ? null
            : List<dynamic>.from(tracks!.map((x) => x.toMap())),
        "sources": sources == null
            ? null
            : List<dynamic>.from(sources!.map((x) => x.toMap())),
        "image": image,
        "analytics": analytics,
        "related": related,
        "advertising": advertising,
      };
}

class Advertising {
  Advertising({
    this.schedule,
    this.podmessage,
    required this.client,
    this.debug,
    this.tag,
  });

  Map<String, dynamic>? schedule;
  String? podmessage;
  String client;
  bool? debug;
  String? tag;

  Advertising copyWith({
    Map<String, dynamic>? schedule,
    String? podmessage,
    String? client,
    bool? debug,
    String? tag,
  }) =>
      Advertising(
        schedule: schedule ?? this.schedule,
        podmessage: podmessage ?? this.podmessage,
        client: client ?? this.client,
        debug: debug ?? this.debug,
        tag: tag ?? this.tag,
      );

  factory Advertising.fromJson(String str) =>
      Advertising.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Advertising.fromMap(Map<String, dynamic> json) => Advertising(
        schedule: json["schedule"],
        podmessage: json["podmessage"],
        client: json["client"],
        debug: json["debug"],
        tag: json["tag"],
      );

  Map<String, dynamic> toMap() => {
        "schedule": schedule,
        "podmessage": podmessage,
        "client": client,
        "debug": debug,
        "tag": tag,
      };
}

class Adbreak {
  Adbreak({
    this.offset,
    required this.tag,
  });

  String? offset;
  String tag;

  Adbreak copyWith({
    String? offset,
    String? tag,
  }) =>
      Adbreak(
        offset: offset ?? this.offset,
        tag: tag ?? this.tag,
      );

  factory Adbreak.fromJson(String str) => Adbreak.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Adbreak.fromMap(Map<String, dynamic> json) => Adbreak(
        offset: json["offset"],
        tag: json["tag"],
      );

  Map<String, dynamic> toMap() => {
        "offset": offset,
        "tag": tag,
      };
}

class Analytics {
  Analytics({
    required this.client,
    this.debug,
  });

  String client;
  bool? debug;

  Analytics copyWith({
    String? client,
    bool? debug,
  }) =>
      Analytics(
        client: client ?? this.client,
        debug: debug ?? this.debug,
      );

  factory Analytics.fromJson(String str) => Analytics.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Analytics.fromMap(Map<String, dynamic> json) => Analytics(
        client: json["client"],
        debug: json["debug"],
      );

  Map<String, dynamic> toMap() => {
        "client": client,
        "debug": debug,
      };
}

class PlaylistItem {
  PlaylistItem({
    this.sources,
    this.image,
    this.title,
    this.adschedule,
    this.tracks,
    this.file,
    this.description,
  });

  List<Source>? sources;
  String? image;
  String? title;
  String? adschedule;
  List<Track>? tracks;
  String? file;
  String? description;

  PlaylistItem copyWith({
    List<Source>? sources,
    String? image,
    String? title,
    String? adschedule,
    List<Track>? tracks,
    String? file,
    String? description,
  }) =>
      PlaylistItem(
        sources: sources ?? this.sources,
        image: image ?? this.image,
        title: title ?? this.title,
        adschedule: adschedule ?? this.adschedule,
        tracks: tracks ?? this.tracks,
        file: file ?? this.file,
        description: description ?? this.description,
      );

  factory PlaylistItem.fromJson(String str) =>
      PlaylistItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlaylistItem.fromMap(Map<String, dynamic> json) => PlaylistItem(
        sources: json["sources"] == null
            ? null
            : List<Source>.from(json["sources"].map((x) => Source.fromMap(x))),
        image: json["image"],
        title: json["title"],
        adschedule: json["adschedule"],
        tracks: json["tracks"] == null
            ? null
            : List<Track>.from(json["tracks"].map((x) => Track.fromMap(x))),
        file: json["file"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "sources": sources == null
            ? null
            : List<dynamic>.from(sources!.map((x) => x.toMap())),
        "image": image,
        "title": title,
        "adschedule": adschedule,
        "tracks": tracks == null
            ? null
            : List<dynamic>.from(tracks!.map((x) => x.toMap())),
        "file": file,
        "description": description,
      };
}

class Source {
  Source({
    required this.file,
  });

  String file;

  factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Source.fromMap(Map<String, dynamic> json) => Source(
        file: json["file"],
      );

  Map<String, dynamic> toMap() => {
        "file": file,
      };
}

class Related {
  Related({
    this.client,
    this.onclick,
    this.oncomplete,
  });

  String? client;
  String? onclick;
  String? oncomplete;

  Related copyWith({
    String? client,
    String? onclick,
    String? oncomplete,
  }) =>
      Related(
        client: client ?? this.client,
        onclick: onclick ?? this.onclick,
        oncomplete: oncomplete ?? this.oncomplete,
      );

  factory Related.fromJson(String str) => Related.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Related.fromMap(Map<String, dynamic> json) => Related(
        client: json["client"],
        onclick: json["onclick"],
        oncomplete: json["oncomplete"],
      );

  Map<String, dynamic> toMap() => {
        "client": client,
        "onclick": onclick,
        "oncomplete": oncomplete,
      };
}

class Track {
  Track({
    required this.file,
    this.label,
    this.kind,
    this.trackDefault,
  });

  String file;
  String? label;
  String? kind;
  bool? trackDefault;

  Track copyWith({
    String? file,
    String? label,
    String? kind,
    bool? trackDefault,
  }) =>
      Track(
        file: file ?? this.file,
        label: label ?? this.label,
        kind: kind ?? this.kind,
        trackDefault: trackDefault ?? this.trackDefault,
      );

  factory Track.fromJson(String str) => Track.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Track.fromMap(Map<String, dynamic> json) => Track(
        file: json["file"],
        label: json["label"],
        kind: json["kind"],
        trackDefault: json["default"],
      );

  Map<String, dynamic> toMap() => {
        "file": file,
        "label": label,
        "kind": kind,
        "default": trackDefault,
      };
}
