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
    token=  box.read(
        'token' );
    super.initState();
    _controller = VideoPlayerController.asset('assets/mov.mp4')
      ..initialize().then((_) {
        _controller.play();

        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.addListener(() {

      if(_controller.value.position == _controller.value.duration) {
        print(token);
if(token!=null){Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) =>
          Statisticss ()),
);}else{
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>
            LoginScr()),
  );
}



      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child: VideoPlayer(_controller),),);
  }
}
