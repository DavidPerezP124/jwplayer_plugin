import 'dart:math';

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import '../models/video_info.dart';

class CardSwipper extends StatelessWidget {
  const CardSwipper({super.key, required this.videos});

  final List<VideoInfo> videos;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      // color: Colors.red,
      child: Swiper(
        itemCount: videos.length,

        layout: SwiperLayout.STACK,
        // itemWidth: size.width * 0.6,
        // itemHeight: size.height * 0.9,

        // layout: SwiperLayout.TINDER,

        // layout: SwiperLayout.CUSTOM,
        // customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
        //   ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
        //   ..addTranslate(
        //       [Offset(-370.0, -40.0), Offset(0.0, 0.0), Offset(370.0, -40.0)]),

        itemWidth: 300.0,
        itemHeight: 400.0,

        itemBuilder: (_, int index) {

          final video = videos[index];
          video.heroId = 'swiper-${video.mediaid}+${DateTime.now()}';

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: video),
            child: Hero(
              tag: video.heroId!,
              child: _CardWidget(video: video),
            ),
          );
        },
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  const _CardWidget({super.key, required this.video});

  final VideoInfo video;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GridTile(
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            // image: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(video.image),
            fit: BoxFit.cover),
          footer: Container(
            padding: EdgeInsets.all(8),
            color: Colors.black.withOpacity(0.4),
            child: Text(
              video.title,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
