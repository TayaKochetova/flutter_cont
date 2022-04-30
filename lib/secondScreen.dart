import 'package:flutter/material.dart';

import 'naturalImage.dart';

class SecondScreen extends StatelessWidget {
  SecondScreen({NaturalImage? natural}) {
    _naturalImage = natural;
  }

  NaturalImage? _naturalImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Column(
        children: [
          Text(
            '${_naturalImage!.name}',
            style: TextStyle(fontSize: 25),
          ),
          Image.network(_naturalImage!.largeImage),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              '${_naturalImage!.description}',
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }
}
