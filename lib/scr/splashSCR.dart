import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sahlaprovider/scr/statistics.dart';
import 'package:video_player/video_player.dart';

import 'login.dart';
import 'offer.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final box = GetStorage();
  String token;
  VideoPlayerController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    token = box.read('token');
    super.initState();
    _controller = VideoPlayerController.asset(
      'assets/mov.mp4',
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) {
        _controller.play();

        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        print(token);
        if (token != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Statisticss()),
            (context) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginScr()),
            (context) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          right: -50,
          left: -50,
          top: -50,
          bottom: -50,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 9,
            height: MediaQuery.of(context).size.height * 1.5,
            child: VideoPlayer(
              _controller,
            ),
          ),
        ),
      ],
    ));
  }
}
