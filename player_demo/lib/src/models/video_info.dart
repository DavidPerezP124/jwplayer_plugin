import 'dart:convert';

import 'playlist_video_player_response.dart';

class VideoInfo {
    VideoInfo({
        required this.title,
        required this.mediaid,
        required this.link,
        required this.image,
        required this.images,
        required this.feedid,
        required this.duration,
        required this.pubdate,
        required this.description,
        required this.tags,
        required this.sources,
        required this.tracks,
        required this.variations,
    });

    String title;
    String mediaid;
    String link;
    String image;
    List<Image> images;
    String feedid;
    int duration;
    int pubdate;
    String description;
    String tags;
    List<Source> sources;
    List<Track> tracks;
    Variations variations;

    String? heroId;

    factory VideoInfo.fromJson(String str) => VideoInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory VideoInfo.fromMap(Map<String, dynamic> json) => VideoInfo(
        title: json["title"],
        mediaid: json["mediaid"],
        link: json["link"],
        image: json["image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        feedid: json["feedid"],
        duration: json["duration"],
        pubdate: json["pubdate"],
        description: json["description"],
        tags: json["tags"],
        sources: List<Source>.from(json["sources"].map((x) => Source.fromMap(x))),
        tracks: List<Track>.from(json["tracks"].map((x) => Track.fromMap(x))),
        variations: Variations.fromMap(json["variations"]),
    );

    Map<String, dynamic> toMap() => {
        "title": title,
        "mediaid": mediaid,
        "link": link,
        "image": image,
        "images": List<dynamic>.from(images.map((x) => x.toMap())),
        "feedid": feedid,
        "duration": duration,
        "pubdate": pubdate,
        "description": description,
        "tags": tags,
        "sources": List<dynamic>.from(sources.map((x) => x.toMap())),
        "tracks": List<dynamic>.from(tracks.map((x) => x.toMap())),
        "variations": variations.toMap(),
    };

    getVideoSource(String label) {
      return this.sources.firstWhere((source) => source.label == label).file;
    }
}