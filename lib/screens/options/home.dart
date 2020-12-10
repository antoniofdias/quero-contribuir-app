import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeWidget extends StatelessWidget {
  void accessUrl(site) async {
    if (await canLaunch(site)) {
      launch(site);
    } else {
      throw "Unable to launch";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: ListView(
        padding: EdgeInsets.only(top: 16),
        children: [
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Github',
                    style: TextStyle(fontSize: 24),
                    maxLines: 1,
                  ),
                ),
                Container(
                  height: 220,
                  padding: EdgeInsets.only(top: 16.0),
                  child: Image.asset('assets/images/github.png'),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
                  child: Text(
                    'The largest and most advanced development platform in the world.',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    maxLines: 3,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  child: FlatButton(
                    onPressed: () => accessUrl('https://github.com'),
                    child: Text(
                      'Access Website',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton.icon(
                onPressed: () {},
                padding: EdgeInsets.all(12.0),
                icon: Icon(
                  Icons.thumb_up,
                  size: 30,
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
                onPressed: () {},
                color: Colors.white,
                padding: EdgeInsets.all(14.0),
                icon: Icon(
                  Icons.thumb_down,
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
