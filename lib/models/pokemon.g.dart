// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Pokemon on _Pokemon, Store {
  late final _$hpAtom = Atom(name: '_Pokemon.hp', context: context);

  @override
  int? get hp {
    _$hpAtom.reportRead();
    return super.hp;
  }

  @override
  set hp(int? value) {
    _$hpAtom.reportWrite(value, super.hp, () {
      super.hp = value;
    });
  }

  late final _$_PokemonActionController =
      ActionController(name: '_Pokemon', context: context);

  @override
  void decrement(int damage) {
    final _$actionInfo =
        _$_PokemonActionController.startAction(name: '_Pokemon.decrement');
    try {
      return super.decrement(damage);
    } finally {
      _$_PokemonActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hp: ${hp}
    ''';
  }
}
