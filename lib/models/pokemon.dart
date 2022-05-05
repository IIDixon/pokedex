import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'pokemon.g.dart';

class Pokemon = _Pokemon with _$Pokemon;

abstract class _Pokemon with Store{
  _Pokemon.setName({required this.name});

  _Pokemon();

  _Pokemon.up({required this.name, this.hp,this.speed, this.def, this.attack });

  _Pokemon.fromJson(Map<String, dynamic> json) : name = json["name"],
        hp = json["stats"][0]["base_stat"],
        speed = json["stats"][5]["base_stat"],
        def = json["stats"][2]["base_stat"],
        attack = json["stats"][1]["base_stat"],
        element = json["types"][0]["type"]["name"],
        img = json["sprites"]["other"]["official-artwork"]["front_default"];

  _Pokemon.fromApi(AsyncSnapshot json) : name = json.data["name"],
        hp = json.data["stats"][0]["base_stat"],
        speed = json.data["stats"][5]["base_stat"],
        def = json.data["stats"][2]["base_stat"],
        attack = json.data["stats"][1]["base_stat"],
        element = json.data["types"][0]["type"]["name"],
        img = json.data["sprites"]["other"]["official-artwork"]["front_default"];

  String? img;
  String? name;
  String? element;

  @observable
  int? hp;

  int? speed;
  int? def;
  int? attack;

  List<int>? doubleDamageFrom; // Sofre dano duplo de...
  List<int>? doubleDamageTo; // Causa dano duple em...
  List<int>? halfDamageFrom; // Sofre metade do dano de...
  List<int>? halfDamageTo; // Causa metade do dano em...

  @action
  void decrement(int damage){
    hp = hp! - damage;
  }

  Map<String, dynamic> toJson(){
    return {'name' : name};
  }
}