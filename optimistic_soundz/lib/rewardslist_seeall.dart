import 'package:flutter/material.dart';
import 'package:optimistic_soundz/rewardslist.dart';
import 'package:optimistic_soundz/pointshop.dart';

class SeeAll extends StatefulWidget {
  final String startingProduct;

  SeeAll(this.startingProduct);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SeeAllState();
  }
}

class SeeAllState extends State<SeeAll> {
  List<String> _products = ['trustedkicks'];

  @override
  void initState() {
    //_products.add(widget.startingProduct);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(height: 20.0),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
              child: const Text(' Promontional Rewards',
                  style: TextStyle(fontSize: 20, color: Colors.white70)),
            )),
        Align(
            alignment: Alignment.topLeft,
            child: Container(
                child: const Text(' see what your community can offer',
                    style: TextStyle(color: Colors.white70)))),
        Container(
          //10 pixel spaces around button
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                //_products.add('Advanced Food Tester');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PointShop()));
              });
            },
            child: const Text('see all'),
          ),
        ),
        RewardsList(_products),
      ],
    );
  }
}
