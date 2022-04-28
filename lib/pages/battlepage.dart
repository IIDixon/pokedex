import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

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
  String log = '';

  Pokemon pokeFirst = Pokemon();
  Pokemon pokeSecondary = Pokemon();

  Future<Map> getPokemonFirst() async{
    http.Response response;

    response = await http.get(Uri.parse(search + namePokemonFirst!));
    return json.decode(response.body);
  }

  Future<Map> getPokemonSecondary() async{
    http.Response response;

    response = await http.get(Uri.parse(search + namePokemonSecondary!));
    return json.decode(response.body);
  }

  void setPokemonFirst(String text) {
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
  }

  void goBattle(Pokemon pokemon) async{
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      log += "Mew causou XX de dano ao pokemon MewTwo\n\n";
    });

    await Future.delayed(const Duration(seconds: 3));
    setState((){
      log += "MewTwo causou YY de dano ao pokemon Mew\n\n";
      log += "MewTwo causou YY de dano ao pokemon Mew\n\n";
      log += "MewTwo causou YY de dano ao pokemon Mew\n\n";
      log += "MewTwo causou YY de dano ao pokemon Mew\n\n";
      log += "MewTwo causou YY de dano ao pokemon Mew\n\n";
      log += "MewTwo causou YY de dano ao pokemon Mew\n\n";
      log += "MewTwo causou YY de dano ao pokemon Mew\n\n";
      log += "MewTwo causou 20 de dano ao pokemon Mew\n\n";
    });
  }

  Widget createPokemon(BuildContext context, AsyncSnapshot snapshot, Pokemon pokemon){
    final url = snapshot.data!["sprites"]["other"]["official-artwork"]["front_default"];
    final hp = snapshot.data!["stats"][0]["base_stat"];
    final attack = snapshot.data!["stats"][1]["base_stat"];
    final defense = snapshot.data!["stats"][2]["base_stat"];
    final speed = snapshot.data!["stats"][5]["base_stat"];
    String name = snapshot.data!["name"];

    pokemon.name = name;
    pokemon.hp = hp;
    pokemon.attack = attack;
    pokemon.def = defense;
    pokemon.speed = speed;

    return Column(
      children: [ Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.green,
                width: 2,
              )
          ),
          child: FadeInImage.memoryNetwork(
            fadeInDuration: const Duration(seconds: 1),
            placeholder: kTransparentImage,
            image: url,
            height: 200,
            width: 150,
            fit: BoxFit.fill,
          )
      ),
        Text("Name - ${pokemon.name}", style: TextStyle(fontSize: 18),),
        Text("HP - ${pokemon.hp}", style: TextStyle(fontSize: 18),),
        Text("Speed - ${pokemon.speed}", style: TextStyle(fontSize: 18),),
        Text("Attack - ${pokemon.attack}" ,style: TextStyle(fontSize: 18),),
        Text("Defense - ${pokemon.def}", style: TextStyle(fontSize: 18),),
    ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (text){
                      if(text != null && text.isNotEmpty){
                        setPokemonFirst(text);
                      }
                    },
                    controller: search1Controller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashColor: Colors.red.withOpacity(0.3),
                          onPressed: (){
                            search1Controller.clear();
                          },
                          icon: const Icon(Icons.close, color: Colors.red,),),
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      label: const Text("Pesquisa"),
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      )
                    ),
                  ),
                ),
                const SizedBox(width: 30,),
                Expanded(
                  child: TextField(
                    onSubmitted: (text){
                      if(text != null && text.isNotEmpty){
                        setPokemonSecondary(text);
                      }
                    },
                    controller: search2Controller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashColor: Colors.red.withOpacity(0.3),
                          onPressed: (){
                            search2Controller.clear();
                          },
                          icon: const Icon(Icons.close, color: Colors.red,),),
                      enabledBorder: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(),
                      label: const Text("Pesquisa"),
                      labelStyle: const TextStyle(
                        fontSize: 18,
                      )
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      FutureBuilder(
                        future: getPokemonFirst(),
                        builder: (context,snapshot){
                          switch(snapshot.connectionState){
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Container(
                                width: 150,
                                height: 200,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                  strokeWidth: 5,
                                ),
                              );
                            default:
                              if(snapshot.hasError){
                                return Container(
                                  width: 150,
                                  height: 200,
                                  child: Column(
                                    children: const [
                                      Icon(Icons.error),
                                      Text("Nenhum pokémon encontrado", softWrap: true,),
                                    ],
                                  ),
                                );
                              } else{
                                return createPokemon(context, snapshot, pokeFirst);
                              }
                          }
                        },
                      ),
                    /*Text("Name - ${pokeFirst.name}", style: TextStyle(fontSize: 18),),
                    Text("HP - ${pokeFirst.hp}", style: TextStyle(fontSize: 18),),
                    Text("Speed - ${pokeFirst.speed}", style: TextStyle(fontSize: 18),),
                    Text("Attack - ${pokeFirst.attack}" ,style: TextStyle(fontSize: 18),),
                    Text("Defense - ${pokeFirst.defense}", style: TextStyle(fontSize: 18),),*/
                  ]
              ),
                  const SizedBox(width: 30,child: Text("VS", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),),
                  Column(
                    children: [
                      FutureBuilder(
                        future: getPokemonSecondary(),
                        builder: (context, snapshot){
                          switch(snapshot.connectionState){
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Container(
                                width: 150,
                                height: 200,
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                  strokeWidth: 5,
                                ),
                              );
                            default:
                              if(snapshot.hasError){
                                return Container(
                                  width: 150,
                                  height: 200,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: const [
                                      Icon(Icons.error),
                                      Text("Nenhum pokémon encontrado",),
                                    ],
                                  ),
                                );
                              } else{
                                return createPokemon(context, snapshot, pokeSecondary);
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
                      /*Text("Name - ${pokeSecondary.name}", style: TextStyle(fontSize: 18,),),
                      Text("HP - ${pokeSecondary.hp}", style: TextStyle(fontSize: 18,),),
                      Text("Speed - ${pokeSecondary.speed}", style: TextStyle(fontSize: 18),),
                      Text("Attack - ${pokeSecondary.attack}" ,style: TextStyle(fontSize: 18),),
                      Text("Defense - ${pokeSecondary.defense}", style: TextStyle(fontSize: 18),),*/
                    ]
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                goBattle(pokeFirst);
              },
              child: Text("Go Battle"),
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
                            color: Colors.black,
                          ),
                        ),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(log),
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
