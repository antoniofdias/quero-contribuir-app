import 'dart:math';

import 'package:flutter/material.dart';

final _tiles = [
  _MyLikesTile(
    'Tensorflow',
    Image.asset('assets/images/tensorflow.jpg'),
    'An Open Source Machine Learning Framework for Everyone',
    'https://github.com/tensorflow/tensorflow',
  ),
  _MyLikesTile(
    'Github',
    Image.asset('assets/images/github.png'),
    'The largest and most advanced development platform in the world.',
    'https://github.com',
  ),
  _MyLikesTile(
    'Geany',
    Image.asset('assets/images/geany.png'),
    'Powerful, stable and lightweight programmer\'s text editor.',
    'https://github.com',
  ),
];

class MyLikesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(0.0),
        child: _tiles[Random().nextInt(_tiles.length)],
      ),
    );
  }
}

class _MyLikesTile extends StatelessWidget {
  _MyLikesTile(this._name, this._image, this._description, this._link);

  final String _name;
  final Image _image;
  final String _description;
  final String _link;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 60.0,
          child: _image,
        ),
        title: Text(
          _name,
          maxLines: 1,
        ),
        subtitle: Text(
          _description,
          maxLines: 3,
        ),
        isThreeLine: true,
      ),
    );
  }
}
