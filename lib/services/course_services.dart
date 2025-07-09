import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/courses_model.dart';

class CourseService {
  final FirebaseFirestore firestore;

  CourseService(this.firestore);

  Future<List<Course>> fetchCourses() async {
    final doc = await firestore.collection('DummyData').doc('courses').get();
    final data = doc.data();

    if (data == null) return [];

    return data.entries.map((entry) {
      final id = entry.key;
      final value = entry.value as Map<String, dynamic>;
      return Course.fromMap(id, value);
    }).toList();
  }
}
