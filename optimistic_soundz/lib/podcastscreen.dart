import 'package:audioplayers/audioplayers.dart';
import 'package:dart_rss/domain/rss_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart' as webfeed;
import 'package:optimistic_soundz/main.dart';
//import 'package:optimistic_soundz/controls.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:optimistic_soundz/episodeScreen.dart';

Color background = Colors.black87;
Color containterBackdrop = Colors.blueGrey;
Color accent = Color.fromRGBO(4, 128, 56, 1);
Color cardColor = Color.fromRGBO(68, 68, 68, 1);
Color textColor = Colors.white70;

class podcastscreen extends StatelessWidget {
  const podcastscreen({
    //required this.audioPlayer,
    required this.title,
    required this.description,
    required this.image,
    required this.episodes,
    // required this.currentPodcast = [],
    Key? key,
  }) : super(key: key);
  final List<RssItem> episodes;
  final String title;
  final String image;
  final String description;
  //final AudioPlayer audioPlayer;

  // List<String> currentPodcast = [title, image, description];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text(""),
          backgroundColor: accent,
        ),
        body: ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  tileColor: cardColor,
                  title: Text(episodes[index].title!,
                      style: TextStyle(color: textColor)),
                  //subtitle: Text(episodes[index].description!),
                  style: ListTileStyle.list,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EpisodeScreen(
                                  //audioPlayer: audioPlayer,
                                  title: episodes[index].title!,
                                  image: image,
                                  author: title,
                                  description: episodes[index].description!,
                                  audio_url: episodes[index].enclosure!.url!,
                                )));
                  }, //push to control page and change controls to inlcude dynamic title and stuff
                ),
                elevation: 4.0,
              );
            }));
  }
}
