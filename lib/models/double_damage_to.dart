class DoubleDamageTo{
  String? type;

  DoubleDamageTo({this.type});

  factory DoubleDamageTo.fromJson(Map<String,dynamic> json) => DoubleDamageTo(type: json["name"]);

  @override
  toString() => '$type';
}