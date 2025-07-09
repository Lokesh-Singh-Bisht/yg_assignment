import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yg_assignment/data/models/user_model.dart';

class UserService {
  Future<UserModel?> getUserById(String userId) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('DummyData')
            .doc('User')
            .get();

    final data = doc.data();
    if (data != null && data.containsKey(userId)) {
      return UserModel.fromMap(Map<String, dynamic>.from(data[userId]));
    }
    return null;
  }
}
