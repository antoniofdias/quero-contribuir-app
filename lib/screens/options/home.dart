import 'dart:math';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final tiles = [
  _ProjectTile(
    'Tensorflow',
    Image.asset('assets/images/tensorflow.png'),
    'An Open Source Machine Learning Framework for Everyone',
    'https://github.com/tensorflow/tensorflow',
  ),
  _ProjectTile(
    'Github',
    Image.asset('assets/images/github.png'),
    'The largest and most advanced development platform in the world.',
    'https://github.com',
  ),
  _ProjectTile(
    'Geany',
    Image.asset('assets/images/geany.png'),
    'Powerful, stable and lightweight programmer\'s text editor.',
    'https://github.com',
  ),
];

class HomeWidget extends StatefulWidget {
  final Function toggleView;
  HomeWidget({this.toggleView});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = Random().nextInt(tiles.length);

  _changeState() {
    setState(() {
      _currentIndex = Random().nextInt(tiles.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: ListView(
        padding: EdgeInsets.only(top: 16.0),
        children: [
          tiles[_currentIndex],
          Container(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton.icon(
                onPressed: _changeState,
                padding: EdgeInsets.all(12.0),
                icon: Icon(
                  Icons.thumb_up,
                  size: 30.0,
                  color: Colors.white,
                ),
                label: Text(
                  'Like',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.brown[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              RaisedButton.icon(
                onPressed: _changeState,
                color: Colors.white,
                padding: EdgeInsets.all(14.0),
                icon: Icon(
                  Icons.thumb_down,
                  size: 30,
                  color: Colors.brown[300],
                ),
                label: Text(
                  'Dislike',
                  style: TextStyle(color: Colors.brown[300], fontSize: 20),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _ProjectTile extends StatelessWidget {
  _ProjectTile(this._name, this._image, this._description, this._link);

  final String _name;
  final Image _image;
  final String _description;
  final String _link;

  _launchURL() async {
    if (await canLaunch(_link)) {
      await launch(_link);
    } else {
      throw 'Could not launch $_link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              _name,
              style: TextStyle(fontSize: 24),
              maxLines: 1,
            ),
          ),
          Container(
            height: 220,
            padding: EdgeInsets.only(top: 16.0),
            child: _image,
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
            child: Text(
              _description,
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
              maxLines: 3,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
            child: FlatButton(
              onPressed: _launchURL,
              child: Text(
                'Access Website',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
