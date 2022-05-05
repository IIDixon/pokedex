import 'dart:math';
import 'package:pokedex/models/pokemon.dart';
import 'package:mobx/mobx.dart';

part 'battle.g.dart';

class Battle = _Battle with _$Battle;

abstract class _Battle with Store{

  @observable
  String log = '';

  final random = Random();

  @action
  int damagePhase(Pokemon pokeAttack, Pokemon pokeDefense) {
    // Status max = 120
    double def = 1 - (pokeDefense.def! / (pokeDefense.def! + 25));
    int totalDamage = (pokeAttack.attack! * def).toInt();
    log += "\n $totalDamage";

    if(pokeDefense.speed! > pokeAttack.speed!){
      totalDamage -= (totalDamage * ((pokeDefense.speed! - pokeAttack.speed!) ~/ 100)).toInt(); // Operador '~/' faz com que seja retornado apenas a parte inteira da divisão
    }

    if(random.nextInt(10) == 1){
      totalDamage += (totalDamage * 0.15).toInt();
      log += "- DANO CRÍTICO";
    }

    pokeDefense.decrement(totalDamage);
    return totalDamage;
  }
}