import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProjectsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('repositories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
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
