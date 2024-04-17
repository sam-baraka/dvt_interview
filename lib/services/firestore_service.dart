import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await _db.collection(collection).add(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getData(String collection) {
    return _db.collection(collection).get();
  }
}
