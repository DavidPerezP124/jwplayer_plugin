// To parse this JSON data, do
//
//     final playlistResponse = playlistResponseFromMap(jsonString);

import 'dart:convert';

import 'playlist.dart';

class PlaylistResponse {
    PlaylistResponse({
        required this.page,
        required this.pageLength,
        required this.playlists,
        required this.total,
    });

    int page;
    int pageLength;
    List<Playlist> playlists;
    int total;

    factory PlaylistResponse.fromJson(String str) => PlaylistResponse.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory PlaylistResponse.fromMap(Map<String, dynamic> json) => PlaylistResponse(
        page: json["page"],
        pageLength: json["page_length"],
        playlists: List<Playlist>.from(json["playlists"].map((x) => Playlist.fromMap(x))),
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "page": page,
        "page_length": pageLength,
        "playlists": List<dynamic>.from(playlists.map((x) => x.toMap())),
        "total": total,
    };
}



class Metadata {
    Metadata({
        this.author,
        required this.customParams,
        this.description,
        this.link,
        required this.title,
    });

    dynamic author;
    Relationships customParams;
    String? description;
    String? link;
    String title;

    factory Metadata.fromJson(String str) => Metadata.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Metadata.fromMap(Map<String, dynamic> json) => Metadata(
        author: json["author"],
        customParams: Relationships.fromMap(json["custom_params"]),
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "author": author,
        "custom_params": customParams.toMap(),
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "title": title,
    };
}

class Relationships {
    Relationships();

    factory Relationships.fromJson(String str) => Relationships.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Relationships.fromMap(Map<String, dynamic> json) => Relationships(
    );

    Map<String, dynamic> toMap() => {
    };
}
