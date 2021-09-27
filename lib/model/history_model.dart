class HistoryModel {
  HistoryModel({
    this.bil1,
    this.bil2,
    this.operasi,
  });

  double? bil1;
  double? bil2;
  String? operasi;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    bil1: json["bil1"]?.toDouble(),
    bil2: json["bil2"]?.toDouble(),
    operasi: json["operasi"],
  );

  Map<String, dynamic> toJson() => {
    "bil1": bil1,
    "bil2": bil2,
    "operasi": operasi,
  };
}
