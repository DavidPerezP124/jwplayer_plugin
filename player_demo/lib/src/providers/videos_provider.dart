import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/playlist.dart';
import '../models/playlist_video_player_response.dart';
import '../models/video_info.dart';
import 'sample_data.dart';
// import '../models/playlist_response.dart';

class VideoProvider extends ChangeNotifier{

  String PLAYLIST_ID_EXAMPLE = 'vXCDG99L';
  String DASHBOARD_ID_EXAMPLE = '2Gmc3jRP';

  List<Playlist> playlists = [];
  List<VideoInfo> videosFromPlaylists = [];
  List<VideoInfo> popularVideosPlaylist = [];

  VideoProvider(){
    // getPlayLists();
    getVideoPlayerFromPlayLists();
    getPopularVideosPlaylist();
  }

  // getPlayLists() async {
  //   var url =
  //     Uri.https('api.jwplayer.com', '/v2/sites/$DASHBOARD_ID_EXAMPLE/playlists/', 
  //     {
  //       'page': '1',
  //       'page_length': '10'
  //     });

  //   // Await the http get response, then decode the json-formatted response.
  //   var response = await http.get(url, headers: {'Authorization' : '5qBYjJG9EZRYfjY36ux_TGInYUhWUlJERkxNSFJaTTNKQlUwUTVUMkpTWWt0alVrbE4n'});
  //   if (response.statusCode == 200) {
  //     final playlistResponse = PlaylistResponse.fromJson(response.body);
  //     // print(playlistResponse.playlists[0].metadata.title);
  //     playlists = playlistResponse.playlists;

  //     notifyListeners();
  //   } else {
  //     print('getPlayLists> ${response.statusCode}');
  //   }
  // }

  getVideoPlayerFromPlayLists() async {
    var url =
      Uri.https('cdn.jwplayer.com', '/v2/playlists/$PLAYLIST_ID_EXAMPLE', {'format': 'json'});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final playlistVideoPlayerResponse = PlaylistVideoPlayerResponse.fromJson(response.body);
      videosFromPlaylists = playlistVideoPlayerResponse.playlist;
      
      notifyListeners();
    } else {
      print('getVideoPlayerFromPlayLists> ${response.statusCode}');
    }
  }

  getPopularVideosPlaylist() async {
    final popularVideosPlaylistResponse = PlaylistVideoPlayerResponse.fromJson(json.encode(playList01));    
    popularVideosPlaylist = popularVideosPlaylistResponse.playlist;

    notifyListeners();
  }
}
