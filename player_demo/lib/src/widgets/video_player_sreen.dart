import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/video_info.dart';

// void main() => runApp(const VideoPlayerApp());

// class VideoPlayerApp extends StatelessWidget {
//   const VideoPlayerApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Video Player Demo',
//       home: VideoPlayerScreen(),
//     );
//   }
// }

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.video});

  final VideoInfo video;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState(video);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  _VideoPlayerScreenState(this.video);

  final VideoInfo video;


  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      video.getVideoSource('720p'),
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);

    _controller.play();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
        Container(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the VideoPlayerController has finished initialization, use
                // the data it provides to limit the aspect ratio of the video.
                return Container(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      ),
                      // Container(
                      //   //duration of video
                      //   child:
                      //       Text("Total Duration: " + _controller.value.duration.toString()),
                      // ),
                      Container(
                        child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          backgroundColor: Colors.grey,
                          playedColor: Colors.redAccent,
                          bufferedColor: Colors.grey,
                          )
                        )
                      ),
                      Container(
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }

                                  setState(() {});
                                },
                                icon: Icon(_controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow)),
                            IconButton(
                                onPressed: () {
                                  _controller.seekTo(Duration(seconds: 0));
                                  _controller.pause();

                                  setState(() {});
                                },
                                icon: Icon(Icons.stop))
                          ],
                        ),
                      )
                    ],
                  ),
                );
                
                
                
                
              } else {
                // If the VideoPlayerController is still initializing, show a
                // loading spinner.
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
  }
}