import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/playlist.dart';
import '../models/playlist_video_player_response.dart';
import '../models/video_info.dart';
import 'sample_data.dart';

// import '../models/playlist_response.dart';
List<VideoInfo> demoConfigs = [
  VideoInfo(
      title: "Night Of The Living Dead",
      image:
          "https://upload.wikimedia.org/wikipedia/commons/4/48/Night_of_the_living_Dead_Logo.png",
      description:
          "'The dead come back to life and eat the living in this low budget, black and white film. Several people barricade themselves inside a rural house in an attempt to survive the night. Outside are hordes of relentless, shambling zombies who can only be killed by a blow to the head.' - IMDb",
      duration: const Duration(hours: 1, minutes: 35, seconds: 55).inSeconds,
      sources: [
        Source(
            file:
                "https://ia600903.us.archive.org/32/items/Night.Of.The.Living.Dead_1080p/NightOfTheLivingDead_720p_512kb.mp4",
            type: "type")
      ]),
  VideoInfo(
      title: "Nosferatu",
      duration: const Duration(hours: 1, minutes: 46, seconds: 51).inSeconds,
      description:
          "'Vampire Count Orlok expresses interest in a new residence and real estate agent Hutter's wife. Wisbourg, Germany based estate agent Knock dispatches his associate, Hutter, to Count Orlok's castle in Transylvania as the Count wants to purchase an isolated house in Wisbourg' - IMDb",
      image:
          "https://upload.wikimedia.org/wikipedia/commons/e/e1/Nosferatu_title.jpg",
      sources: [
        Source(
            file:
                "https://ia802204.us.archive.org/11/items/videoplayback-5_202203/videoplayback%20%285%29.mp4",
            type: "type")
      ])
];

class VideoProvider extends ChangeNotifier {
  // ignore: non_constant_identifier_names
  String PLAYLIST_ID_EXAMPLE = 'vXCDG99L';
  // ignore: non_constant_identifier_names
  String DASHBOARD_ID_EXAMPLE = '2Gmc3jRP';

  List<Playlist> playlists = [];
  List<VideoInfo> videosFromPlaylists = [];
  List<VideoInfo> popularVideosPlaylist = [...demoConfigs];

  VideoProvider() {
    getPlayLists();
    getVideoPlayerFromPlayLists();
    getPopularVideosPlaylist();
  }

  getPlayLists() async {
    var url = Uri.https(
        'api.jwplayer.com',
        '/v2/sites/$DASHBOARD_ID_EXAMPLE/playlists/',
        {'page': '1', 'page_length': '10'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final playlistResponse =
          PlaylistVideoPlayerResponse.fromJson(response.body);

      videosFromPlaylists.addAll(playlistResponse.playlist);

      notifyListeners();
    } else {
      debugPrint('getPlayLists> ${response.statusCode}');
    }
  }

  getVideoPlayerFromPlayLists() async {
    var url = Uri.https('cdn.jwplayer.com',
        '/v2/playlists/$PLAYLIST_ID_EXAMPLE', {'format': 'json'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final playlistVideoPlayerResponse =
          PlaylistVideoPlayerResponse.fromJson(response.body);
      videosFromPlaylists = playlistVideoPlayerResponse.playlist;
      videosFromPlaylists.addAll(popularVideosPlaylist);
      notifyListeners();
    } else {
      debugPrint('getVideoPlayerFromPlayLists> ${response.statusCode}');
    }
  }

  getPopularVideosPlaylist() async {
    final popularVideosPlaylistResponse =
        PlaylistVideoPlayerResponse.fromJson(json.encode(playList01));
    popularVideosPlaylist =
        popularVideosPlaylist + popularVideosPlaylistResponse.playlist;

    notifyListeners();
  }
}
