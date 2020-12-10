import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference repositoryCollection =
      FirebaseFirestore.instance.collection('repositories');

  Future<void> addRepo(repoData) async {
    repositoryCollection.add(repoData).catchError((e) {
      print(e);
    });
  }
}
