import 'dart:convert';

import 'playlist_response.dart';

class Playlist {
    Playlist({
        required this.created,
        required this.id,
        required this.lastModified,
        required this.metadata,
        required this.playlistType,
        required this.relationships,
        this.schema,
        required this.type,
    });

    DateTime created;
    String id;
    DateTime lastModified;
    Metadata metadata;
    String playlistType;
    Relationships relationships;
    dynamic schema;
    String type;

    factory Playlist.fromJson(String str) => Playlist.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Playlist.fromMap(Map<String, dynamic> json) => Playlist(
        created: DateTime.parse(json["created"]),
        id: json["id"],
        lastModified: DateTime.parse(json["last_modified"]),
        metadata: Metadata.fromMap(json["metadata"]),
        playlistType: json["playlist_type"],
        relationships: Relationships.fromMap(json["relationships"]),
        schema: json["schema"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "created": created.toIso8601String(),
        "id": id,
        "last_modified": lastModified.toIso8601String(),
        "metadata": metadata.toMap(),
        "playlist_type": playlistType,
        "relationships": relationships.toMap(),
        "schema": schema,
        "type": type,
    };
}