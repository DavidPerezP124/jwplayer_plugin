import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_demo/src/providers/videos_provider.dart';
// import 'package:flutter_demo/src/widgets/card_swipper.dart';
// import 'package:flutter_demo/src/widgets/video-slider.dart';
import '../providers/videos_provider.dart';
import '../widgets/card_swipper.dart';
import '../widgets/video-slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final videoProvider = Provider.of<VideoProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Videos'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Cardswipper
              CardSwipper( videos: videoProvider.popularVideosPlaylist ),

              SizedBox( height: 15 ),

              // list of popular
              VideoSlider( 
                videos: videoProvider.videosFromPlaylists,
                title: 'Videos with captions'
              ),
              
            ],
          ),
        ));
  }
}
