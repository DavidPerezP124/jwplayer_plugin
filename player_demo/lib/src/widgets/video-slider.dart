import 'package:flutter/material.dart';

import '../models/video_info.dart';

class VideoSlider extends StatelessWidget {
  const VideoSlider({super.key, required this.videos, this.title});

  final List<VideoInfo> videos;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (this.title != null) 
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(this.title!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ),
          
        SizedBox( height: 8 ),

        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (_, int index) => _VideoPoster( video: videos[index] ),
          ),
        ),
      ]),
    );
  }
}

class _VideoPoster extends StatelessWidget {
  const _VideoPoster({super.key, required this.video});

  final VideoInfo video;

  @override
  Widget build(BuildContext context) {

    video.heroId = 'slider-${video.mediaid}';

    return Container(
      width: 300,
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: video),
            child: Hero(
              tag: video.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  // image: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(video.image),
                  width: 300,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 5,
          ),

          Text(
            video.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}
