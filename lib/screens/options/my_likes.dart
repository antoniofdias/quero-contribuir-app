import 'package:flutter/material.dart';

class MyLikesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(0.0),
        child: MyLikesTile(),
      ),
    );
  }
}

class MyLikesTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset('assets/images/github.png'),
        title: Text('Github'),
        subtitle: Text(
          'The largest and most advanced development platform in the world.',
          maxLines: 3,
        ),
        isThreeLine: true,
      ),
    );
  }
}
