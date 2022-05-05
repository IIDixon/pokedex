import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mobx/flutter_mobx.dart';

import '../models/battle.dart';

class BattlePage extends StatefulWidget {
  BattlePage({Key? key}) : super(key: key);

  @override
  _BattlePageState createState() => _BattlePageState();
}

class _BattlePageState extends State<BattlePage> {

  final logController = TextEditingController();
  final search1Controller = TextEditingController();
  final search2Controller = TextEditingController();
  final search = "https://pokeapi.co/api/v2/pokemon/";
  String? namePokemonFirst;
  String? namePokemonSecondary;
  Battle battle = Battle();

  late List<String?> listPoke = [namePokemonFirst,namePokemonSecondary];

  Pokemon pokeFirst = Pokemon();
  Pokemon pokeSecondary = Pokemon();

  Future<Map> getPokemonFirst() async{
    http.Response response;

    response = await http.get(Uri.parse(search + listPoke[0]!));
    return json.decode(response.body);
  }

  Future<Map> getPokemonSecondary() async{
    http.Response response;

    response = await http.get(Uri.parse(search + listPoke[1]!));
    return json.decode(response.body);
  }

/*  void setPokemonFirst(String text) {
    setState(() {
      if (text != null && text.isNotEmpty) {
        namePokemonFirst = text;
      }
    });
  }

  void setPokemonSecondary(String text) {
    setState(() {
      if (text != null && text.isNotEmpty) {
        namePokemonSecondary = text;
      }
    });
  }*/

  void setPokemon(String text, int id){
    setState(() {
      if (text != null && text.isNotEmpty) {
        listPoke[id] = text;
      }
    });
  }

  void goBattle(Pokemon pokeOne, Pokemon pokeTwo) async{
    battle.log = '';
    battle.log += "Combate iniciado\n";
    battle.log += "Pontos de Vida ${pokeOne.name} - ${pokeOne.hp}\n";
    battle.log += "Pontos de Vida ${pokeTwo.name} - ${pokeTwo.hp}\n\n";
    while(pokeOne.hp! > 0 && pokeTwo.hp! > 0){
      await Future.delayed(const Duration(seconds: 5));
      battle.log += "${pokeOne.name} ataca ${pokeTwo.name} causando ${battle.damagePhase(pokeOne, pokeTwo)} pontos de dano\n";
      battle.log += "${pokeTwo.name} agora está com ${pokeTwo.hp} pontos de vida\n\n";

      if(pokeTwo.hp! <= 0){
        battle.log += "${pokeTwo.name} teve seus pontos de vida reduzidos a 0\n";
        battle.log += "${pokeOne.name} venceu o combate";
        break;
      }

      await Future.delayed(const Duration(seconds: 5));
      battle.log += "${pokeTwo.name} ataca ${pokeOne.name} causando ${battle.damagePhase(pokeTwo, pokeOne)} pontos de dano\n";
      battle.log += "${pokeOne.name} agora está com ${pokeOne.hp} pontos de vida\n\n";

      if(pokeOne.hp! <= 0){
        battle.log += "${pokeOne.name} teve seus pontos de vida reduzidos a 0\n";
        battle.log += "${pokeTwo.name} venceu o combate";
        break;
      }
    }
  }

  Widget createTextField(BuildContext context, TextEditingController searchcontroller, int id){
    return TextField(
      onSubmitted: (text){
        if(text != null && text.isNotEmpty){
          setPokemon(text, id);
        }
      },
      controller: searchcontroller,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            splashColor: Colors.red.withOpacity(0.3),
            onPressed: (){
              setState(() {
                listPoke[id] = ' ';
                searchcontroller.clear();
              });
            },
            icon: const Icon(Icons.close, color: Colors.red,),),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurpleAccent),
          ),
          label: const Text("Search pokemon"),
          labelStyle: const TextStyle(
            fontSize: 18,
            color: Colors.deepPurpleAccent,
          )
      ),
    );
  }

  Widget createPokemon(BuildContext context, Pokemon pokemon){
    /*final url = snapshot.data!["sprites"]["other"]["official-artwork"]["front_default"];
    final hp = snapshot.data!["stats"][0]["base_stat"];
    final attack = snapshot.data!["stats"][1]["base_stat"];
    final defense = snapshot.data!["stats"][2]["base_stat"];
    final speed = snapshot.data!["stats"][5]["base_stat"];
    String name = snapshot.data!["name"];

    pokemon.name = name;
    pokemon.hp = hp;
    pokemon.attack = attack;
    pokemon.def = defense;
    pokemon.speed = speed;*/

    return Column(
      children: [ Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
          ),
          child: FadeInImage.memoryNetwork(
            fadeInDuration: const Duration(seconds: 1),
            placeholder: kTransparentImage,
            image: pokemon.img!,
            height: 200,
            width: 150,
            fit: BoxFit.fill,
          )
      ),
        Row(
          children: [
            const Text("Name - ", style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1)),
              ),
                child: Text("${pokemon.name}",style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary),textAlign: TextAlign.end,)),
          ],
        ),
        Row(
          children: [
            const Text("HP - ", style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
            Observer(builder: (_)=>Text("${pokemon.hp}",style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary), textAlign: TextAlign.end,),)
          ],
        ),
        Row(
          children: [
            const Text("Speed - ", style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
            Text("${pokemon.speed}", style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary), textAlign: TextAlign.end,)
          ],
        ),
        Row(
          children: [
            const Text("Attack - " ,style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
            Text("${pokemon.attack}", style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary), textAlign: TextAlign.end,)
          ],
        ),
        Row(
          children: [
            const Text("Defense - ", style: TextStyle(fontSize: 18, color: Colors.deepPurpleAccent),),
            Text("${pokemon.def}", style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.primary), textAlign: TextAlign.end,)
          ],
        ),
    ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: createTextField(context, search1Controller,0),
                ),
                const SizedBox(width: 70,),
                Expanded(
                    child: createTextField(context, search2Controller,1),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    future: getPokemonFirst(),
                    builder: (context,snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                            width: 150,
                            height: 150,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                              strokeWidth: 5,
                            ),
                          );
                        default:
                          if(snapshot.hasError){
                            return Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              child: Column(
                                children: const [
                                  Icon(Icons.error),
                                  Text("no pokemon found", softWrap: true,),
                                ],
                              ),
                            );
                          } else{
                            pokeFirst = Pokemon.fromApi(snapshot);
                            return createPokemon(context, pokeFirst);
                          }
                      }
                    },
                  ),
                  const SizedBox(width: 30,child: Text("VS", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),),
                  FutureBuilder(
                    future: getPokemonSecondary(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                              strokeWidth: 5,
                            ),
                          );
                        default:
                          if(snapshot.hasError){
                            return Container(
                              width: 100,
                              height: 100,
                              alignment: Alignment.center,
                              child: Column(
                                children: const [
                                  Icon(Icons.error),
                                  Text("no pokemon found",),
                                ],
                              ),
                            );
                          } else{
                            pokeSecondary = Pokemon.fromApi(snapshot);
                            return createPokemon(context, pokeSecondary);
                          }
                      }
                    },
                    /*child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          )
                      ),
                      child: FadeInImage.memoryNetwork(
                        fadeInDuration: const Duration(seconds: 2),
                        placeholder: kTransparentImage,
                        image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/132.png",
                        height: 200,
                        width: 150,
                        fit: BoxFit.fill,
                      )
                    ),*/
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                pokeFirst.hp != null && pokeSecondary.hp != null ? goBattle(pokeFirst, pokeSecondary) :
                  const AlertDialog(title: Text('Iniciar Batalha'), content: Text('Selecione corretamente os pokemons'),);
              },
              child: const Text("Go Battle"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child:
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Observer(builder: (_) => Text(battle.log, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}
