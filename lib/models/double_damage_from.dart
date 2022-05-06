class DoubleDamageFrom{
  String? type;
  String? url;

  DoubleDamageFrom({this.type, this.url});

  factory DoubleDamageFrom.fromJson(Map<String, dynamic> json) => DoubleDamageFrom(type: json["name"], url: json["url"]);
}