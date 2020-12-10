import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quero_contribuir/screens/options/my_likes.dart';
import 'package:url_launcher/url_launcher.dart';

final _tiles = [
  _ProjectTile(
    'Tensorflow',
    Image.asset('assets/images/tensorflow.jpg'),
    'Um projeto Open Source de Machine Learning Framework para todos',
    'https://github.com/tensorflow/tensorflow',
  ),
  _ProjectTile(
    'Developer Roadmap',
    Image.asset('assets/images/github.png'),
    'Um guia sobre como se tornar um desenvolvedor em 2020.',
    'https://github.com/kamranahmedse/developer-roadmap',
  ),
  _ProjectTile(
    'Geany',
    Image.asset('assets/images/geany.png'),
    'Editor de texto para programadores poderoso, estável e leve.',
    'https://github.com/geany/geany',
  ),
  _ProjectTile(
    'Apache Cassandra',
    Image.asset('assets/images/apache.png'),
    'Banco de dados descentralizado projetado para gerenciar grandes quantidades de dados.',
    'https://github.com/apache/cassandra',
  ),
  _ProjectTile(
    'Linux',
    Image.asset('assets/images/linux.png'),
    'Open Source kernel de um dos mais importantes sistemas do mundo',
    'https://github.com/torvalds/linux',
  ),
  _ProjectTile(
    'Django',
    Image.asset('assets/images/django.png'),
    'Framework Web Python de alto nível que incentiva o desenvolvimento rápido e um design limpo.',
    'https://github.com/django/django',
  ),
  _ProjectTile(
    'React',
    Image.asset('assets/images/react.png'),
    'Uma biblioteca JavaScript declarativa, eficiente e flexível para construir interfaces de usuário.',
    'https://github.com/facebook/react',
  ),
  _ProjectTile(
    'Swift',
    Image.asset('assets/images/swift.png'),
    'Linguagem de programação Swift usada em aplicativos para iPhone.',
    'https://github.com/apple/swift',
  ),
  _ProjectTile(
    'Free Programming Books',
    Image.asset('assets/images/github.png'),
    'Livros de programação disponibilizados gratuitamente.',
    'https://cassandra.apache.org',
  ),
  _ProjectTile(
    'Kodi',
    Image.asset('assets/images/kodi.png'),
    'Software de home theater/media center e hub de entretenimento para mídia digital.',
    'https://github.com/xbmc/xbmc',
  ),
];

class HomeWidget extends StatefulWidget {
  final Function toggleView;
  HomeWidget({this.toggleView});

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = Random().nextInt(_tiles.length);

  _changeState(bool add) {
    if (add) {
      liked_tiles.add(MyLikesTile(
        _tiles[_currentIndex].name,
        _tiles[_currentIndex].image,
        _tiles[_currentIndex].description,
        _tiles[_currentIndex].link,
      ));
    }
    setState(() {
      _currentIndex = Random().nextInt(_tiles.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: ListView(
        padding: EdgeInsets.only(top: 16.0),
        children: [
          _tiles[_currentIndex],
          Container(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton.icon(
                onPressed: () {
                  _changeState(true);
                },
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
                onPressed: () {
                  _changeState(false);
                },
                color: Colors.white,
                padding: EdgeInsets.all(12.0),
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

  String get name => _name;
  Image get image => _image;
  String get description => _description;
  String get link => _link;

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
