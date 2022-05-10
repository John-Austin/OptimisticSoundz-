//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Color background = Colors.black87;
Color containterBackdrop = Colors.blueGrey;
Color accent = Color.fromRGBO(4, 128, 56, 1);
Color cardColor = Color.fromRGBO(68, 68, 68, 1);
Color textColor = Colors.white70;

/// Play Widget Work
class Controls extends StatefulWidget {
  const Controls(
      { //required this.audioPlayer,
      required this.title,
      required this.image,
      required this.description,
      required this.author,
      required this.audio,
      Key? key})
      : super(key: key);
  final String title;
  final String image;
  final String description;
  final String author;
  final String audio;
  //final AudioPlayer audioPlayer;

  @override
  _PlaybackbuttonState createState() => _PlaybackbuttonState();
}

class _PlaybackbuttonState extends State<Controls> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  final StopWatchTimer tracker = StopWatchTimer();
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  //AudioPlayer audioPlayer = audioPlayer;
  @override
  void initState() {
    super.initState();
    /* instance of audioPlayerclass */
    //
    setAudio();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    //audioPlayer.dispose();
    //cleanup();
    //audioPlayer.stop();
    //audioPlayer.release();
    audioPlayer.stop();
    tracker.onExecute.add(StopWatchExecute.stop);
    super.dispose();
    tracker.dispose();
    //audioPlayer.dispose();
  }

  void cleanup() async {
    if (audioPlayer.state == PlayerState.PLAYING ||
        audioPlayer.state == PlayerState.PAUSED) {
      await audioPlayer.stop();
    }
  }

  Future<void> _incrementOnplay() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String? uid = _firebaseAuth.currentUser?.uid.toString();
    var user = FirebaseFirestore.instance.collection('users').doc(uid);

    user.update({"points": FieldValue.increment(20)});
  }

  Future setAudio() async {
    audioPlayer.setUrl(widget.audio);
  }

  @override
  Widget build(BuildContext context) {
    tracker.secondTime.listen((value) => _incrementOnplay());
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        //title: const Text("Controls Page"),
        elevation: 4.0,
        backgroundColor: accent,
      ),
      body: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Image.network(widget.image,
              width: double.infinity, height: 350, fit: BoxFit.cover),
          //margin: const EdgeInsets.all(20),
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: 25, color: textColor),
          textAlign: TextAlign.center,
        ),
        Text(widget.author, style: TextStyle(fontSize: 20, color: textColor)),
        Slider(
          inactiveColor: textColor,
          thumbColor: accent,
          activeColor: accent,
          min: 0,
          max: duration.inSeconds.toDouble(),
          value: position.inSeconds.toDouble(),
          onChanged: (value) async {
            final position = Duration(seconds: value.toInt());
            await audioPlayer.seek(position);

            await audioPlayer.resume();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatTime(position),
                style: TextStyle(color: textColor),
              ),
              Text(formatTime(duration - position),
                  style: TextStyle(color: textColor)),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
                backgroundColor: accent,
                radius: 35,
                child: IconButton(
                  icon: Icon(
                    Icons.fast_rewind_rounded,
                    color: textColor,
                  ),
                  iconSize: 50,
                  onPressed: () async {
                    final Duration newPosition =
                        Duration(seconds: position.inSeconds - 15);
                    await audioPlayer.seek(newPosition);
                  },
                )),
            CircleAvatar(
                backgroundColor: accent,
                radius: 35,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: textColor,
                  ),
                  iconSize: 50,
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                      tracker.onExecute.add(StopWatchExecute.stop);
                    } else {
                      await audioPlayer.resume();
                      tracker.onExecute.add(StopWatchExecute.start);
                    }
                  },
                )),
            CircleAvatar(
                backgroundColor: accent,
                radius: 35,
                child: IconButton(
                  icon: Icon(
                    Icons.fast_forward_rounded,
                    color: textColor,
                  ),
                  iconSize: 50,
                  onPressed: () async {
                    final Duration newPosition =
                        Duration(seconds: position.inSeconds + 15);
                    await audioPlayer.seek(newPosition);
                  },
                )),
          ],
        )
      ]),
    );
  }
}

String formatTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));

  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}
