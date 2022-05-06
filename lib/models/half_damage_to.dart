class HalfDamageTo{
  String? type;

  HalfDamageTo({this.type});

  factory HalfDamageTo.fromJson(Map<String, dynamic> json) => HalfDamageTo(type: json["name"]);

  @override
  toString() => "$type";
}