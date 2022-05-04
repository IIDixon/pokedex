import 'package:pokedex/models/pokemon.dart';

class Battle {

  String? log;

  int damagePhase(Pokemon pokeAttack, Pokemon pokeDefense) {
    // Status max = 120
    int totalDamage = (pokeAttack.attack! * (pokeDefense.def! ~/ (pokeDefense.def! + 100))).toInt();

    if(pokeDefense.speed! > pokeAttack.speed!){
      totalDamage -= (totalDamage * ((pokeDefense.speed! - pokeAttack.speed!) ~/ 100)).toInt(); // Operador '~/' faz com que seja retornado apenas a parte inteira da divisão
    }
    pokeDefense.decrement(totalDamage);
    return totalDamage;
  }
}