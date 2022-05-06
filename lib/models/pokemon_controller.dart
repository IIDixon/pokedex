import 'package:pokedex/models/double_damage_to.dart';
import 'package:pokedex/models/half_damage_to.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonController{
  /*late final List<DoubleDamageFrom>? doubleDamageFrom;*/
  late final List<DoubleDamageTo>? doubleDamageTo;
  /*late final List<HalfDamageFrom>? halfDamageFrom;*/
  late final List<HalfDamageTo>? halfDamageTo;

  PokemonController({this.doubleDamageTo,this.halfDamageTo});

  // Atribui á lista de regras de dano de acordo com o tipo
  void addList(Pokemon pokemon){
    /*pokemon.doubleDamageFrom = doubleDamageFrom;*/
    pokemon.doubleDamageTo = doubleDamageTo;
    /*pokemon.halfDamageFrom = halfDamageFrom;*/
    pokemon.halfDamageTo = halfDamageTo;
  }

  double damageTo(Pokemon pokemonAttack, Pokemon pokemonDefense){
    if(pokemonAttack.doubleDamageTo!.any((element) => element.type == pokemonDefense.element)){ // Verifica se o pokemon atacante causa dano duplo no pokemon defensor
      return 1.3; // Causa 30% a mais de dano
    } else if(pokemonAttack.halfDamageTo!.any((element) => element.type == pokemonDefense.element)){ // Verifica se o pokemon atacante causa dano reduzido no pokemon defensor
      return 0.3; // Causa 30% a menos de dano
    } else {
      return 1;
    }
  }

  factory PokemonController.fromJson(Map<dynamic, dynamic> json) => PokemonController(
    // doubleDamageFrom: (json["damage_relations"]["double_damage_from"] as List).map((e) => DoubleDamageFrom.fromJson(e)).toList(),
    doubleDamageTo: (json["damage_relations"]["double_damage_to"] as List).map((e) => DoubleDamageTo.fromJson(e)).toList(),
    // halfDamageFrom: (json["damage_relations"]["half_damage_from"] as List).map((e) => HalfDamageFrom.fromJson(e)).toList(),
    halfDamageTo: (json["damage_relations"]["half_damage_to"] as List).map((e) => HalfDamageTo.fromJson(e)).toList()
  );
}