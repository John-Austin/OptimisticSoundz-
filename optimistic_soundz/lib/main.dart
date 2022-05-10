import 'package:flutter/material.dart';
import 'package:optimistic_soundz/counterstuff.dart';
import 'package:optimistic_soundz/rewardslist_seeall.dart';
import 'package:optimistic_soundz/settings.dart';
import 'package:optimistic_soundz/profile.dart';
import 'package:optimistic_soundz/rssReader.dart';
//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:optimistic_soundz/Podcast.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart' as webfeed;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml2json/xml2json.dart';
import 'dart:convert';
import 'package:optimistic_soundz/podcastscreen.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:optimistic_soundz/rssReader.dart';
import 'package:optimistic_soundz/userlogin.dart';
import 'package:optimistic_soundz/controls.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  reader = RSSReader();
  Future.delayed(Duration(seconds: 2));
  runApp(
    const PodcastApp(),
  );
}

//Color background = Color.fromRGBO(18, 22, 64, 1);
Color background = Colors.black87;
//Color background = Colors.white;
Color containterBackdrop = Colors.blueGrey;
Color accent = Color.fromRGBO(4, 128, 56, 1);
Color cardColor = Color.fromRGBO(68, 68, 68, 1);
Color textColor = Colors.white70;
late RSSReader reader;
//late AudioPlayer _audioPlayer;

List<String> podcast_names = [
  "Such A F N Lady",
  "Cuttin Up Cousins",
  "Down To Mars",
  "Alive in Christ Church",
  "The Black Butterfly Experience",
  "Bianca Talks Policy, Politics & Hip Hop",
  "UpGrade Media Arts Schools Podcast"
];
List<String> urls = [
  "https://feeds.soundcloud.com/users/soundcloud:users:279134006/sounds.rss",
  "https://anchor.fm/s/17960aac/podcast/rss",
  "https://anchor.fm/s/1283df6c/podcast/rss",
  "https://anchor.fm/s/859b2c8/podcast/rss",
  "https://anchor.fm/s/49f497c0/podcast/rss",
  "https://anchor.fm/s/6a1f1250/podcast/rss",
  "https://anchor.fm/s/3b29fe38/podcast/rss",
  "https://anchor.fm/s/6a21b03c/podcast/rss"
];

class PodcastApp extends StatelessWidget {
  const PodcastApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimisitc Soundz',
      home: Login(),
    );
  }
}

//Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // final feed = fetchPodcast();
    // updateFeeds(feed);
    print("initState");
    //_audioPlayer = AudioPlayer();
    super.initState();
    //_audioPlayer = AssetsAudioPlayer();
    //reader = RSSReader();
  }

  static List<Widget> _navBarOptions = <Widget>[
    Library(),
    RewardsRouter(),
    Profile(),
    //Settings(),
  ];

  void _onBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: accent,
        //title: const Text('Optimistic Soundz+'),
        elevation: 4.0,
        /*actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => {
                    //Navigator.push(context,
                    //  MaterialPageRoute(builder: (context) => Search()))
                    showSearch(context: context, delegate: MySearchDelegate())
                  })
        ],*/
      ),
      body: _navBarOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: accent,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on_outlined), label: 'Rewards'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          /*BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),*/
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onBarItemTapped,
      ),
      /*bottomSheet: Card(
          child: Column(
            children: [
              Slider.adaptive(value: 0, onChanged: (value) {}),
              Row(
                children: [
                  //Slider(),
                  Image.asset('assets/images/Dash.png'),
                  Column(
                    children: [
                      Text("title goes here"),
                      Text("Author goes Here")
                    ],
                  ),
                  CircleAvatar(
                      radius: 15,
                      child: IconButton(
                        icon: Icon(Icons.play_arrow),
                        iconSize: 25,
                        onPressed: () {},
                      )),
                ],
              ),
            ],
          ),
        )*/
    );
  }
}

//Home Screen Stuff
class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  final List<PodcastCard> _podcasts = [];
  var podcasts = reader.fetchPodcasts();
  //bool loaded = false;
  late Future<bool> loaded;

  @override
  void initState() {
    loaded = reader.loaded();
    //_populatePodcasts();
    super.initState();
    //reader.populateDict();
  }

  int index = 0;
  void _populatePodcasts() {
    var podcast_title;
    var podcast_image;
    var podcast_description;
    var podcast_episodes;
    var counter = 0;
    //setState(() {});
    //setState(() {
    for (var p in podcast_names) {
      //setState(() {
      //podcast_text = reader.feeds[counter]!.title;
      if (reader.feeds.length == RSSReader.urls.length) {
        //loaded = true;
        podcast_title = reader.feeds[counter]!.title;
        podcast_image = reader.feeds[counter]!.image!.url;
        podcast_description = reader.feeds[counter]!.description;
        podcast_episodes = reader.feeds[counter]!.items;
      } else {
        podcast_title = "loading...";
        podcast_image = "loading...";
        podcast_description = "loading...";
        podcast_episodes = reader.feed.items;
      }
      var podcast = PodcastCard(
        title: podcast_title,
        image: podcast_image,
        description: podcast_description,
        episodes: podcast_episodes,
      );
      _podcasts.insert(index, podcast);
      // might need to change 0
      //});
      index += 1;
      counter += 1;
    }
    // }); // set state ending
  }

  @override
  Widget build(BuildContext context) {
    /*if (loaded == true) {
      return Container(
          child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            padding: const EdgeInsets.all(10.0),
            reverse: false,
            itemBuilder: (_, index) => _podcasts[index],
            itemCount: _podcasts.length,
          ))
        ],
      ));
    } else {
      return Container(
        child: const CircularProgressIndicator(),
        alignment: Alignment.center,
      );
    }*/

    return Container(
        child: FutureBuilder(
      future: reader.loaded(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          _populatePodcasts();
          //note for further thought. Need to reevaluate how to repopulate podcast cards once data has been retrieved.
          return Column(
            children: [
              Flexible(
                  child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                reverse: false,
                itemBuilder: (_, index) => _podcasts[index],
                itemCount: _podcasts.length,
              ))
            ],
          );
        }
        return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator());
      },
    ));
  }
}

class PodcastCard extends StatelessWidget {
  //set up image and description using YT tutorials in discord.
  const PodcastCard(
      {required this.title,
      required this.image,
      required this.description,
      required this.episodes,
      Key? key})
      : super(key: key);
  final String title;
  final String image;
  final String description;
  final List<RssItem> episodes;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
      child: Card(
        //margin: EdgeInsetsGeometry.infinity,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: InkWell(
            splashColor: accent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LandingPage(
                            title: title,
                            image: image,
                            description: description,
                            episodes: episodes,
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(this.image))),
                Padding(padding: EdgeInsets.all(3)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 3)),
                    SizedBox(
                        width: 260,
                        child: Text(this.title,
                            maxLines: 3,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold))),
                    Padding(padding: EdgeInsets.all(3)),
                    SizedBox(
                      width: 260,
                      height: 75,
                      child: Text(
                        this.description,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
                //Padding(
                // padding: EdgeInsets.all(3),
                //),
              ],
            )),
      ),
    );
  }
}

//Search Stuff

class SearchButton extends StatefulWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  _SearchButtonState createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//Podcast Landing Page

class LandingPage extends StatefulWidget {
  const LandingPage(
      {required this.title,
      required this.image,
      required this.description,
      required this.episodes,
      Key? key})
      : super(key: key);
  final String image;
  final String title;
  final String description;
  final List<RssItem> episodes;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        //title: Text("Podcast Landing Page"),
        elevation: 4,
        backgroundColor: accent,
      ),
      backgroundColor: background,
      body: Column(
        children: [
          //Spacer(),
          Align(
              alignment: Alignment.center,
              child: ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Image.network(widget.image))),
          //Text(""),
          Padding(
            padding: EdgeInsets.all(3),
          ),
          Text(widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: textColor)),
          //Text(""),
          Padding(
            padding: EdgeInsets.all(3),
          ),
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
                          widget.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w300, color: textColor),
                          maxLines: 7,
                        )),
                  ))),
          Row(children: [
            Spacer(),
            Text(
              "View Episode List: ",
              style: TextStyle(color: textColor),
            ),
            IconButton(
                icon: Icon(
                  Icons.view_agenda,
                  color: Colors.white70,
                ),
                onPressed: () => {
                      //MaterialPageRoute(podcastscreen);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => podcastscreen(
                                  //audioPlayer: _audioPlayer,
                                  title: widget.title,
                                  description: widget.description,
                                  image: widget.image,
                                  episodes: widget.episodes)))
                    }),
            Spacer(),
          ]),
          Spacer()
          /*Column(
            children: [
              Spacer(),
              ListView.builder(
                  itemCount: widget.episodes.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(widget.episodes[index].title!));
                  }),
              Spacer(),
            ],
          ),*/
        ],
      ),
      /*floatingActionButton: FloatingActionButton.extended(
          onPressed: () => {},
          icon: Icon(Icons.play_arrow_rounded),
          label: Text("Start Listening")),*/
    );
  }
}

//rewards quick fix
class RewardsRouter extends StatelessWidget {
  const RewardsRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [CountUp(), SeeAll('confetti')]);
  }
}

// Search Functionality

// Search Code

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    "Such A F N Lady",
    "Cuttin Up Cousins",
    "Down To Mars",
    "Alive in Christ Church",
    "The Black Butterfly Experience",
    "Bianca Talks Policy, Politics & Hip Hop",
    "UpGrade Media Arts Schools Podcast"
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // return Center(
    //   child: Text(query),
    // );
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final String title = "Test";
    final String description = "Test";
    final String image = "Test";
    // TODO: implement buildSuggestions
    List<String> suggestedPocasts = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: suggestedPocasts.length,
        itemBuilder: (context, index) {
          final suggestion = suggestedPocasts[index];
          return ListTile(
              title: Text(suggestion),
              onTap: () {
                query = suggestion;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LandingPage(
                              title: title,
                              image: image,
                              description: description,
                              episodes: [],
                            )));
              });
        });
  }
}
