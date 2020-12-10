import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyItemsWidget extends StatelessWidget {
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
              child: _myItemsTile(context, snapshot.data.documents[index]),
            ),
          );
        });
  }
}

Widget _myItemsTile(BuildContext context, DocumentSnapshot document) {
  void sendEmail(address) async {
    String message = "mailto:" + address + "?subject=Quero Contribuir";

    if (await canLaunch(message)) {
      launch(message);
    } else {
      throw 'Unable to launch';
    }
  }

  void accessUrl(site) async {
    String cleanurl = 'https://' + site;
    if (await canLaunch(cleanurl)) {
      launch(cleanurl);
    } else {
      throw "Unable to launch";
    }
  }

  return GestureDetector(
      onTap: () => accessUrl(document['repoLink']),
      child: Card(
        child: ListTile(
          leading: Image.asset('assets/images/github.png'),
          title: Text(document['repoName']),
          subtitle: Text(
            document['repoDescription'],
            maxLines: 3,
          ),
          isThreeLine: true,
          trailing: GestureDetector(
            onTap: () => sendEmail(document['repoContact']),
            child: Icon(Icons.mail),
          ),
        ),
      ));
}
