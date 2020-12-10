import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

List<MyLikesTile> liked_tiles = [];

class MyLikesWidget extends StatelessWidget {
  void unique() {
    List<String> names = [];
    List<MyLikesTile> tmp = [];
    for (MyLikesTile x in liked_tiles) {
      if (!names.contains(x.name)) {
        tmp.add(x);
        names.add(x.name);
      }
    }
    liked_tiles = tmp;
  }

  @override
  Widget build(BuildContext context) {
    unique();
    return ListView.builder(
      itemCount: liked_tiles.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(0.0),
        child: liked_tiles[index],
      ),
    );
  }
}

class MyLikesTile extends StatelessWidget {
  MyLikesTile(this._name, this._image, this._description, this._link);

  final String _name;
  final Image _image;
  final String _description;
  final String _link;

  String get name => _name;

  void sendEmail(address) async {
    String message = "mailto:" + address + "?subject=Quero Contribuir";

    if (await canLaunch(message)) {
      launch(message);
    } else {
      throw 'Unable to launch';
    }
  }

  void accessUrl(site) async {
    if (await canLaunch(site)) {
      launch(site);
    } else {
      throw "Unable to launch";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => accessUrl(_link),
      child: Card(
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
          trailing: GestureDetector(
            onTap: () => sendEmail('github@github.com'),
            child: Icon(Icons.mail),
          ),
        ),
      ),
    );
  }
}
