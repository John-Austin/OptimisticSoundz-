import 'package:flutter/material.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:http/http.dart' as http;
import 'package:optimistic_soundz/globals.dart';
import 'package:webfeed/webfeed.dart' as webfeed;
import 'package:url_launcher/url_launcher.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RSSReader {
  static const List<String> urls = [
    //add soundcloud
    //"https://feeds.soundcloud.com/users/soundcloud:users:279134006/sounds.rss",
    "https://anchor.fm/s/17960aac/podcast/rss",
    "https://anchor.fm/s/1283df6c/podcast/rss",
    "https://anchor.fm/s/859b2c8/podcast/rss",
    "https://anchor.fm/s/49f497c0/podcast/rss",
    "https://anchor.fm/s/6a1f1250/podcast/rss",
    "https://anchor.fm/s/3b29fe38/podcast/rss",
    "https://anchor.fm/s/6a21b03c/podcast/rss"
  ];

  List<String> firebaseFeeds = [];

  static const urlTest = 'https://anchor.fm/s/6a21b03c/podcast/rss';

  RssFeed feed = RssFeed();

  Map<String, RssFeed> podcastFeeds = {};
  List<RssFeed?> feeds = [];

  static const String loadingMessage = "Loading Feed...";
  static const String loadErrorMessage = "Error Loading Feed.";
  static const String openErrorMessage = "Error Opening Feed";

  RSSReader() {
    //firebaseFeeds = fetchRSS();
    //fetchRSS();
    //Future.delayed(Duration(seconds: 2));
    for (var element in urls) {
      //print("element: ");
      //print(element);
      load(element);
    }

    //print("Here");
    //print(feeds);
  }

  void fetchRSS() async {
    List<String> feeds = [];
    var snapshot = await FirebaseFirestore.instance
        .collection('podcasts')
        .doc('rss_feeds')
        .get();
    Map<String, dynamic> docData = snapshot.data()!;
    docData.forEach((key, value) {
      feeds.add(docData[key].toString());
    });
    firebaseFeeds = feeds;
    //return feeds;
  }

  Future<List<RssFeed?>?> fetchPodcasts() async {
    if (feeds.length == urls.length) {
      return feeds;
    } else {
      return null;
    }
  }

  Future<bool> loaded() async {
    /*while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield feeds.length == urls.length;
    }*/ //if using stream builder
    await Future.delayed(Duration(seconds: 1));
    if (feeds.length == urls.length) {
      return true;
    } else {
      return throw Exception("Exception");
    }

    // return throw Exception("Exception"); //use if future is better.
  }

  void updateFeed(feed) {
    this.feed = feed;
    // print(feed);
    //print(this.feed.title);
    //print(this.feed.author);
    feeds.add(feed);
    podcastFeeds[this.feed.author!] = this.feed;
    //print(feeds);
    //print(podcastFeeds);
  }

  RssFeed getFeed() {
    return feed;
  }

  Future<bool>? populateDict() {
    for (var element in urls) {
      load(element);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      debugPrint("populateDict Fuction");
      if (podcastFeeds.isNotEmpty) {
        print("return true");
        return true;
      } else {
        print("return false");
        return false;
      }
    });
  }

  load(String url) {
    //RssFeed channel;
    loadFeed(url).then((result) {
      //print(result);
      if (null == result || result.toString().isEmpty) {
        //print(loadErrorMessage);
        return null;
      }
      updateFeed(result);
    });
  }

  Future<RssFeed?> loadFeed(String url) async {
    Future<RssFeed> feed;
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(url));
      return RssFeed.parse(response.body);
    } catch (e) {
      //print(loadErrorMessage);
    }
    return null;
  }
}
