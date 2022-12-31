import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class MoviePlayer extends StatefulWidget {
  final Movie movie;
  const MoviePlayer({Key? key, required this.movie}) : super(key: key);

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    print("getVideo init");

    videoPlayerController = VideoPlayerController.network(
        "https://www.youtube.com/embed//6JnN1DmbqoU")
      ..initialize().then((value) {
        setState(() {});
      });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
    );

    // Future.microtask(
    //   () => {
    //     context.read<MovieProvider>().getVideo(widget.movie.id).then((res) {
    //       print("v path $res");
    //       videoPlayerController = VideoPlayerController.asset(res)
    //         ..initialize().then((value) {
    //           setState(() {});
    //         });

    //       chewieController = ChewieController(
    //         videoPlayerController: videoPlayerController,
    //         aspectRatio: 16 / 9,
    //       );
    //     }),
    //   },
    // );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String videoPath = context.watch<MovieProvider>().videoPath;
    // videoPlayerController = VideoPlayerController.asset(videoPath)
    //   ..initialize().then((value) {
    //     setState(() {});
    //   });

    // chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   aspectRatio: 16 / 9,
    // );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
