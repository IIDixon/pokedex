import 'dart:convert';
import 'package:pokedex/models/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pokemonRepository{
  late SharedPreferences sharedPreferences;

  Future<String> getPokemonSaved() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString('pokemon') ?? '[]';

    final jsonDecoded = json.decode(jsonString) as String;
    return jsonDecoded.toString();
  }

  void savePokemon(String pokemon){
    final jsonString = json.encode(pokemon);
    sharedPreferences.setString('pokemon', jsonString);
  }
}