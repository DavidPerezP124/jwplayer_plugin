// import 'package:flutter/material.dart';

// import 'package:video_player/video_player.dart';

// import '../models/video_info.dart';

// class VideoPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {

//     final VideoInfo video = ModalRoute.of(context)!.settings.arguments as VideoInfo;

//     print(video.title);

//     return Container(
//       child: Home(video: video),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({super.key, required this.video});

//   final VideoInfo video;

//   @override
//   _HomeState createState() => _HomeState(video: video);
// }

// class _HomeState extends State<Home> {
//   // const VideoPage({super.key});
//   _HomeState({required this.video});

//   final VideoInfo video;
//   late VideoPlayerController controller;

//   @override
//   void initState() {
//     super.initState();

//     loadVideoPlayer();
//     controller.play();
//   }

//   @override
//   void dispose() {
//     // Ensure disposing of the VideoPlayerController to free up resources.
//     controller.dispose();

//     super.dispose();
//   }

//   loadVideoPlayer() {
//     // Set video
//     controller = VideoPlayerController.network(getVideoSource(video));

//     controller.addListener(() {
//       setState(() {});
//     });
//     controller.initialize().then((value) {
//       setState(() {});
//     });
//   }

//   String getVideoSource(VideoInfo video) {
//     return video.sources.firstWhere((source) => source.label == '720p').file;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(video.title),
//         // backgroundColor: Colors.redAccent,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             AspectRatio(
//               aspectRatio: controller.value.aspectRatio,
//               child: VideoPlayer(controller),
//             ),
//             Container(
//               //duration of video
//               child:
//                   Text("Total Duration: " + controller.value.duration.toString()),
//             ),
//             Container(
//                 child: VideoProgressIndicator(controller,
//                     allowScrubbing: true,
//                     colors: VideoProgressColors(
//                       backgroundColor: Colors.grey,
//                       playedColor: Colors.redAccent,
//                       bufferedColor: Colors.grey,
//                     ))),
//             Container(
//               child: Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         if (controller.value.isPlaying) {
//                           controller.pause();
//                         } else {
//                           controller.play();
//                         }

//                         setState(() {});
//                       },
//                       icon: Icon(controller.value.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow)),
//                   IconButton(
//                       onPressed: () {
//                         controller.seekTo(Duration(seconds: 0));
//                         controller.pause();

//                         setState(() {});
//                       },
//                       icon: Icon(Icons.stop))
//                 ],
//               ),
//             )
//         ]
//       )
//       ),
//     );
//   }
// }
