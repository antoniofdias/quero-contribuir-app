import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// final _tiles = [
//   _MyProjectsTile(
//     'Tensorflow',
//     Image.asset('assets/images/tensorflow.jpg'),
//     'An Open Source Machine Learning Framework for Everyone',
//     'https://github.com/tensorflow/tensorflow',
//   ),
//   _MyProjectsTile(
//     'Github',
//     Image.asset('assets/images/github.png'),
//     'The largest and most advanced development platform in the world.',
//     'https://github.com',
//   ),
//   _MyProjectsTile(
//     'Geany',
//     Image.asset('assets/images/geany.png'),
//     'Powerful, stable and lightweight programmer\'s text editor.',
//     'https://github.com',
//   ),
// ];

class MyProjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('repositories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text('Loading...');
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(0.0),
              child: _MyProjectsTile(
                snapshot.data.documents[index]['repoName'],
                Image.asset('assets/images/github.png'),
                snapshot.data.documents[index]['repoDescription'],
                snapshot.data.documents[index]['repoLink'],
                snapshot.data.documents[index]['repoContact'],
              ),
            ),
          );
        });
  }
}

class _MyProjectsTile extends StatelessWidget {
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

  _MyProjectsTile(
      this._name, this._image, this._description, this._link, this._contact);

  final String _name;
  final Image _image;
  final String _description;
  final String _link;
  final String _contact;

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
            onTap: () => sendEmail(_contact),
            child: Icon(Icons.mail),
          ),
        ),
      ),
    );
  }
}
