import 'package:flutter/material.dart';

class RewardsList extends StatelessWidget {
  final List<String> rewards;
  RewardsList(this.rewards) {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: rewards
            .map(
              (element) => Card(
                elevation: 8.0,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset('images/os_logo.jpg'),
                      height: 250,
                      width: 150,
                    ),
                    //Text(element)
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
