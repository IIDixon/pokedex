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

    // Cálculo da % de dano defendida
    double def = 1 - (pokeDefense.def! / (pokeDefense.def! + 25));

    // Calculo do dano causado reduzindo de acordo com a defesa
    int totalDamage = (pokeAttack.attack! * def).toInt();

    // Calculo da % de chance de causar dano crítico de acordo com a velocidade do pokemon atacante
    double chanceCriticalStrike = pokeAttack.speed! / (pokeAttack.speed! + 50);

    // Calculo de esquiva
    // Caso o pokemon defensor tenha mais velocidade que o pokemon atacante, o defensor absorve uma pequena quantidade do dano recebido
    if(pokeDefense.speed! > pokeAttack.speed!){
      totalDamage -= (totalDamage * ((pokeDefense.speed! - pokeAttack.speed!) / 200)).toInt(); // Operador '~/' faz com que seja retornado apenas a parte inteira da divisão
    }

    if(random.nextDouble() <= chanceCriticalStrike){
      totalDamage = (totalDamage * 1.15).toInt(); // Dano crítico causa 15% a mais de dano, para calcular multiplica-se o dano por 1.15
    }

    pokeDefense.decrement(totalDamage);
    return totalDamage;
  }
}