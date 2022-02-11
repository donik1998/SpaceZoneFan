class EpicImageModel {
  EpicImageModel({
    this.caption,
    this.image,
    this.date,
  });

  String? caption;
  String? image;
  DateTime? date;

  factory EpicImageModel.fromJson(Map<String, dynamic> json) => EpicImageModel(
        caption: json["caption"],
        image: json["image"],
        date: DateTime.parse(json["date"]),
      );
}
