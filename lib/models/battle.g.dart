// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Battle on _Battle, Store {
  late final _$logAtom = Atom(name: '_Battle.log', context: context);

  @override
  String get log {
    _$logAtom.reportRead();
    return super.log;
  }

  @override
  set log(String value) {
    _$logAtom.reportWrite(value, super.log, () {
      super.log = value;
    });
  }

  late final _$_BattleActionController =
      ActionController(name: '_Battle', context: context);

  @override
  int damagePhase(Pokemon pokeAttack, Pokemon pokeDefense) {
    final _$actionInfo =
        _$_BattleActionController.startAction(name: '_Battle.damagePhase');
    try {
      return super.damagePhase(pokeAttack, pokeDefense);
    } finally {
      _$_BattleActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
log: ${log}
    ''';
  }
}
