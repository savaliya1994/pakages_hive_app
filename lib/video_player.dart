import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? controller;
  @override
  void initState() {
    controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://player.vimeo.com/external/371817283.sd.mp4?s=56639e00db07ad3f26d837314e3da531bad01b1b&profile_id=164&oauth2_token_id=57447761'))
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            controller!.value.isPlaying
                ? controller!.pause()
                : controller!.play();
          });
        },
        child: controller!.value.isPlaying
            ? Icon(
                Icons.pause,
                size: 30,
              )
            : Icon(
                Icons.play_arrow,
                size: 30,
              ),
      ),
      body: controller!.value.isInitialized
          ? Center(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: VideoPlayer(controller!)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        controller!.value.isPlaying
                            ? controller!.pause()
                            : controller!.play();
                      });
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: controller!.value.isPlaying
                          ? Colors.transparent
                          : Colors.white,
                      child: Icon(
                        controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: controller!.value.isPlaying
                            ? Colors.transparent
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
              ),
            ),
      // @override
      // Widget build(BuildContext context) {
      //   return MaterialApp(
      //     title: 'Video Demo',
      //     home: Scaffold(
      //       body: Center(
      //         child: controller!.value.isInitialized
      //             ? AspectRatio(
      //                 aspectRatio: controller!.value.aspectRatio,
      //                 child: VideoPlayer(controller!),
      //               )
      //             : Container(),
      //       ),
      //       floatingActionButton: FloatingActionButton(
      //         onPressed: () {
      //           setState(() {
      //             controller!.value.isPlaying
      //                 ? controller!.pause()
      //                 : controller!.play();
      //           });
      //         },
      //         child: Icon(
      //           controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //         ),
      //       ),
      //     ),
    );
  }
}
