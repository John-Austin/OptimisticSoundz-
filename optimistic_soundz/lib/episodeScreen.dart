import 'package:flutter/material.dart';
import 'package:optimistic_soundz/controls.dart';

Color background = Colors.black87;
Color containterBackdrop = Colors.blueGrey;
Color accent = Color.fromRGBO(4, 128, 56, 1);
Color cardColor = Color.fromRGBO(68, 68, 68, 1);
Color textColor = Colors.white70;

class EpisodeScreen extends StatelessWidget {
  const EpisodeScreen(
      {required this.title,
      required this.image,
      required this.author,
      required this.description,
      required this.audio_url,
      Key? key})
      : super(key: key);

  final String title;
  final String image;
  final String author;
  final String description;
  final String audio_url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        //title: const Text("Episode Details"),
        elevation: 4.0,
        backgroundColor: accent,
      ),
      body: Column(
        children: [
          Image.network(image),
          Text(title,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
          Padding(
            padding: EdgeInsets.all(3),
          ),
          Text(author, style: TextStyle(fontSize: 14, color: textColor)),
          //Text(description),
          Align(
              alignment: Alignment.center,
              child: Card(
                  color: cardColor,
                  child: SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: textColor),
                          maxLines: 4,
                        ),
                      )))),
          Padding(
            padding: EdgeInsets.all(15),
          ),
          CircleAvatar(
              backgroundColor: accent,
              radius: 35,
              child: IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: textColor,
                ),
                iconSize: 50,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => Controls(
                              title: title,
                              image: image,
                              author: author,
                              description: description,
                              audio: audio_url))));
                },
              )),
        ],
      ),
    );
  }
}
