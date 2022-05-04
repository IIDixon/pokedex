import 'dart:math';

import 'package:pokedex/models/pokemon.dart';

class Battle {

  String? log;
  final random = Random();

  int damagePhase(Pokemon pokeAttack, Pokemon pokeDefense) {
    // Status max = 120
    int totalDamage = (pokeAttack.attack! * 1 - (pokeDefense.def! ~/ (pokeDefense.def! + 25))).toInt();

    if(pokeDefense.speed! > pokeAttack.speed!){
      totalDamage -= (totalDamage * ((pokeDefense.speed! - pokeAttack.speed!) ~/ 100)).toInt(); // Operador '~/' faz com que seja retornado apenas a parte inteira da divisão
    }

    if(random.nextInt(10) == 1){
      totalDamage += (totalDamage * 0.15).toInt();
    }

    pokeDefense.decrement(totalDamage);
    return totalDamage;
  }
}