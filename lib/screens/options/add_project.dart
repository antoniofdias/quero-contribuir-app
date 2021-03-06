import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quero_contribuir/services/auth.dart';
import 'package:quero_contribuir/services/database.dart';

class AddProject extends StatefulWidget {
  final Function toggleView;
  AddProject({this.toggleView});

  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  DatabaseService db = new DatabaseService();
  AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  File _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String _name = '';
  String _description = '';
  String _link = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Add project'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.brown,
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                Container(height: 24.0),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter Name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) => val.isEmpty ? 'Enter a name' : null,
                  onChanged: (val) {
                    setState(() {
                      _name = val;
                    });
                  },
                ),
                Container(height: 24.0),
                TextFormField(
                  maxLines: 5,
                  decoration: new InputDecoration(
                    labelText: "Enter Description",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Enter a description.' : null,
                  onChanged: (val) {
                    setState(() {
                      _description = val;
                    });
                  },
                ),
                Container(
                  height: 24.0,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter a Valid Link to the Project",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter a link.' : null,
                  onChanged: (val) {
                    setState(() {
                      _link = val;
                    });
                  },
                ),
                Container(
                  height: 24.0,
                ),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Map<String, dynamic> repoData = {
                        'repoName': _name,
                        'repoDescription': _description,
                        'repoLink': _link,
                        'repoLikes': 0,
                        'repoContact': _auth.getUserEmail()
                      };
                      db.addRepo(repoData);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
