import 'package:flutter/material.dart';
import 'tarjeta.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class SesionVideo extends StatefulWidget {
  SesionVideo({this.nombrecurso, this.url, this.tituloclase, this.docente});
  final String nombrecurso;
  final url;
  String url1="https://www.youtube.com/watch?v=RPHdeC-QQOM";
  final String docente;
  final String tituloclase;
  @override
  _SesionVideo createState() => _SesionVideo();
}

class _SesionVideo extends State<SesionVideo> {
  YoutubePlayerController _controller;
  void runYoutubePlayer(){
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url1),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: false,
        )
    );
  }

  @override
  void initState(){
    runYoutubePlayer();
    super.initState();

  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,

        ),
        builder: (context, player){
          var _checked;
          return Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    player,
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Tarjeta()),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

