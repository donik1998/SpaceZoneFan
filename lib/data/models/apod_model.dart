class APODModel {
  final String? copyright, explanation, url, hdurl, mediaType, title;
  final DateTime? date;

  APODModel({
    this.copyright,
    this.explanation,
    this.url,
    this.hdurl,
    this.mediaType,
    this.title,
    this.date,
  });

  factory APODModel.fromJson(Map<String, dynamic> jsonData) {
    return APODModel(
      copyright: jsonData['copyright'],
      date: DateTime.parse(jsonData['date']),
      explanation: jsonData['explanation'],
      hdurl: jsonData['hdurl'],
      url: jsonData['url'],
      mediaType: jsonData['media_type'],
      title: jsonData['title'],
    );
  }
}
