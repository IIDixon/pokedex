import 'package:flutter/cupertino.dart';

class Pokemon{
  Pokemon.setName({required this.name});

  Pokemon.up({required this.name, this.hp,this.speed, this.def, this.attack });

  Pokemon.fromJson(Map<String, dynamic> json) : name = json["name"];

  Pokemon.fromApi(AsyncSnapshot json) : name = json.data["name"],
        hp = json.data["stats"][0]["base_stat"],
        speed = json.data["stats"][5]["base_stat"],
        def = json.data["stats"][2]["base_stat"],
        attack = json.data["stats"][1]["base_stat"],
        element = json.data["types"][0]["type"]["name"],
        img = json.data["sprites"]["other"]["official-artwork"]["front_default"];

  String? img;
  String? name;
  String? element;
  int? hp;
  int? speed;
  int? def;
  int? attack;

  Map<String, dynamic> toJson(){
    return {'name' : name};
  }
}