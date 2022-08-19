// To parse this JSON data, do
//
//     final playlistVideoPlayerResponse = playlistVideoPlayerResponseFromMap(jsonString);

import 'dart:convert';

import 'video_info.dart';

class PlaylistVideoPlayerResponse {
    PlaylistVideoPlayerResponse({
        required this.title,
        required this.description,
        required this.kind,
        required this.feedid,
        required this.links,
        required this.playlist,
        required this.feedInstanceId,
    });

    String title;
    String description;
    String kind;
    String feedid;
    Links links;
    List<VideoInfo> playlist;
    String feedInstanceId;

    factory PlaylistVideoPlayerResponse.fromJson(String str) => PlaylistVideoPlayerResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PlaylistVideoPlayerResponse.fromMap(Map<String, dynamic> json) => PlaylistVideoPlayerResponse(
        title: json["title"],
        description: json["description"],
        kind: json["kind"],
        feedid: json["feedid"],
        links: Links.fromMap(json["links"]),
        playlist: List<VideoInfo>.from(json["playlist"].map((x) => VideoInfo.fromMap(x))),
        feedInstanceId: json["feed_instance_id"],
    );

    Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "kind": kind,
        "feedid": feedid,
        "links": links.toMap(),
        "playlist": List<dynamic>.from(playlist.map((x) => x.toMap())),
        "feed_instance_id": feedInstanceId,
    };
}

class Links {
    Links({
        required this.first,
        required this.last,
    });

    String first;
    String last;

    factory Links.fromJson(String str) => Links.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Links.fromMap(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
    );

    Map<String, dynamic> toMap() => {
        "first": first,
        "last": last,
    };
}

// class VideoPlayer {
//     VideoPlayer({
//         required this.title,
//         required this.mediaid,
//         required this.link,
//         required this.image,
//         required this.images,
//         required this.feedid,
//         required this.duration,
//         required this.pubdate,
//         required this.description,
//         required this.tags,
//         required this.sources,
//         required this.tracks,
//         required this.variations,
//     });

//     String title;
//     String mediaid;
//     String link;
//     String image;
//     List<Image> images;
//     String feedid;
//     int duration;
//     int pubdate;
//     String description;
//     String tags;
//     List<Source> sources;
//     List<Track> tracks;
//     Variations variations;

//     factory VideoPlayer.fromJson(String str) => VideoPlayer.fromMap(json.decode(str));

//     String toJson() => json.encode(toMap());

//     factory VideoPlayer.fromMap(Map<String, dynamic> json) => VideoPlayer(
//         title: json["title"],
//         mediaid: json["mediaid"],
//         link: json["link"],
//         image: json["image"],
//         images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
//         feedid: json["feedid"],
//         duration: json["duration"],
//         pubdate: json["pubdate"],
//         description: json["description"],
//         tags: json["tags"],
//         sources: List<Source>.from(json["sources"].map((x) => Source.fromMap(x))),
//         tracks: List<Track>.from(json["tracks"].map((x) => Track.fromMap(x))),
//         variations: Variations.fromMap(json["variations"]),
//     );

//     Map<String, dynamic> toMap() => {
//         "title": title,
//         "mediaid": mediaid,
//         "link": link,
//         "image": image,
//         "images": List<dynamic>.from(images.map((x) => x.toMap())),
//         "feedid": feedid,
//         "duration": duration,
//         "pubdate": pubdate,
//         "description": description,
//         "tags": tags,
//         "sources": List<dynamic>.from(sources.map((x) => x.toMap())),
//         "tracks": List<dynamic>.from(tracks.map((x) => x.toMap())),
//         "variations": variations.toMap(),
//     };
// }

class Image {
    Image({
        required this.src,
        required this.width,
        required this.type,
    });

    String src;
    int width;
    String type;

    factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Image.fromMap(Map<String, dynamic> json) => Image(
        src: json["src"],
        width: json["width"],
        type: json["type"],
    );

    Map<String, dynamic> toMap() => {
        "src": src,
        "width": width,
        "type": type,
    };
}

class Source {
    Source({
        required this.file,
        required this.type,
        this.height,
        this.width,
        this.label,
        this.bitrate,
        this.filesize,
        this.framerate,
    });

    String file;
    String type;
    int? height;
    int? width;
    String? label;
    int? bitrate;
    int? filesize;
    double? framerate;

    factory Source.fromJson(String str) => Source.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Source.fromMap(Map<String, dynamic> json) => Source(
        file: json["file"],
        type: json["type"],
        height: json["height"] == null ? null : json["height"],
        width: json["width"] == null ? null : json["width"],
        label: json["label"] == null ? null : json["label"],
        bitrate: json["bitrate"] == null ? null : json["bitrate"],
        filesize: json["filesize"] == null ? null : json["filesize"],
        framerate: json["framerate"] == null ? null : json["framerate"],
    );

    Map<String, dynamic> toMap() => {
        "file": file,
        "type": type,
        "height": height == null ? null : height,
        "width": width == null ? null : width,
        "label": label == null ? null : label,
        "bitrate": bitrate == null ? null : bitrate,
        "filesize": filesize == null ? null : filesize,
        "framerate": framerate == null ? null : framerate,
    };
}

class Track {
    Track({
        required this.file,
        required this.kind,
        this.label,
    });

    String file;
    String kind;
    String? label;

    factory Track.fromJson(String str) => Track.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Track.fromMap(Map<String, dynamic> json) => Track(
        file: json["file"],
        kind: json["kind"],
        label: json["label"] == null ? null : json["label"],
    );

    Map<String, dynamic> toMap() => {
        "file": file,
        "kind": kind == null ? null : kind,
        "label": label == null ? null : label,
    };
}

class Variations {
    Variations();

    factory Variations.fromJson(String str) => Variations.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Variations.fromMap(Map<String, dynamic> json) => Variations(
    );

    Map<String, dynamic> toMap() => {
    };
}
