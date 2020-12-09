import 'package:flutter/material.dart';
import 'package:quero_contribuir/screens/options/add_item.dart';
import 'package:quero_contribuir/screens/options/home.dart';
import 'package:quero_contribuir/screens/options/my_items.dart';
import 'package:quero_contribuir/screens/options/my_likes.dart';
import 'package:quero_contribuir/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyStatefulWidget();
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final AuthService _auth = AuthService();

  int _currentIndex = 0;
  bool _isFloatingVisible = false;

  static const _widgetOptions = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.thumb_up_sharp),
      label: 'My likes',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.computer),
      label: 'My items',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 2) {
        _isFloatingVisible = true;
      } else {
        _isFloatingVisible = false;
      }
    });
  }

  Widget _currentWidget(int index) {
    if (index == 0) {
      return HomeWidget();
    } else if (index == 1) {
      return MyLikesWidget();
    } else {
      return MyItemsWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Quero Contribuir'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
      ),
      body: _currentWidget(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _widgetOptions,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.brown[400],
        onTap: _onItemTapped,
      ),
      floatingActionButton: Visibility(
        visible: _isFloatingVisible,
        child: FloatingActionButton(
          backgroundColor: Colors.pink[400],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddItem()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
