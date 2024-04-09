import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static Future<String> fetchUsername(String uid) async {
    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (docSnapshot.exists) {
      return docSnapshot.data()?['username'] ?? 'Unknown';
    }
    return 'Unknown';
  }
}
