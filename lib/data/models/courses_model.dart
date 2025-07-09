class Course {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final String pdfUrl;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.pdfUrl,
  });

  factory Course.fromMap(String id, Map<String, dynamic> data) {
    return Course(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      videoUrl: data['videoUrl'] ?? '',
      pdfUrl: data['pdfUrl'] ?? '',
    );
  }
}
