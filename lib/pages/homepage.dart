import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokedex/repositories/pokemon_repository.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/pokemon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PokemonRepository pokeRepository = PokemonRepository();
  final searchController = TextEditingController();
  final search = "https://pokeapi.co/api/v2/pokemon/";
  String? namePokemon;

  late Pokemon poke;

  Future<Map> getPokemon() async{
    http.Response response;

    /*if(namePokemon == null || searchController.text.isEmpty){
      response = await http.get(Uri.parse(search + "squirtle"));
    } else{
      response = await http.get(Uri.parse(search + namePokemon!));
    }*/
    response = await http.get(Uri.parse(search + namePokemon!));
    return json.decode(response.body);
  }

  @override
  void initState(){
    super.initState();

    pokeRepository.getPokemonSaved().then((value){
      setState(() {
        namePokemon = value;
      });
    });
  }

  void setPokemon(String text){
    setState(() {
      if(text != null && text.isNotEmpty){
        namePokemon = text;
        pokeRepository.savePokemon(namePokemon!);
      }
    });
  }

 Widget createDataPokemon(BuildContext context, Pokemon pokemon){
    /*final url = snapshot.data!["sprites"]["other"]["official-artwork"]["front_default"];
    final hp = snapshot.data!["stats"][0]["base_stat"];
    final attack = snapshot.data!["stats"][1]["base_stat"];
    final defense = snapshot.data!["stats"][2]["base_stat"];
    //final attackSpecial = snapshot.data!["stats"][3]["base_stat"];
    //final defenseSpecial = snapshot.data!["stats"][4]["base_stat"];
    final speed = snapshot.data!["stats"][5]["base_stat"];
    String element = snapshot.data!["types"][0]["type"]["name"];
    String name = snapshot.data!["name"];*/

    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  )
                ),
                height: 300,
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: pokemon.img!,
                  height: 300,
                  fit: BoxFit.fill,
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Name: ", style: TextStyle(color: Colors.green, fontSize: 22),),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.green, width: 1)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(pokemon.name!.toUpperCase(), style: const TextStyle(color: Colors.green, fontSize: 22,),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Type: ", style: TextStyle(color: Colors.green, fontSize: 22),),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.green, width: 1)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(pokemon.element!.toUpperCase(), style: const TextStyle(fontSize: 22, color: Colors.green),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        children: [
                          const Icon(Icons.favorite, color: Colors.red, size: 40,),
                          Text("HP - ${pokemon.hp}", style: const TextStyle(fontSize: 22, color: Colors.green ),),
                          Row(children:const [SizedBox(height: 25,)],),
                          const FaIcon(FontAwesomeIcons.fire, color: Colors.deepOrange, size: 38,),
                          Text("Attack - ${pokemon.attack}", style: const TextStyle(fontSize: 22, color: Colors.green),)
                        ],
                    ),
                    const SizedBox(width: 80,),
                    Column(
                      children: [
                        const Icon(Icons.speed, color: Colors.blueAccent, size: 40,),
                        Text("Speed - ${pokemon.speed}", style: const TextStyle(fontSize: 22, color: Colors.green),),
                        Row(children:const [SizedBox(height: 25,)],),
                        const FaIcon(FontAwesomeIcons.shieldHeart, color: Colors.brown, size: 38),
                        Text("Defense - ${pokemon.def}", style: const TextStyle(fontSize: 22, color: Colors.green),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Pokedex"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);

          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (text){
                        if(text != null && text.isNotEmpty){
                          setPokemon(text);
                        }
                      },
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          focusColor: Colors.red,
                          splashColor: Colors.red.withOpacity(0.3),
                            onPressed: (){
                              searchController.clear();
                            },
                            icon: const Icon(Icons.close, color: Colors.red,),),
                        labelText: 'Name of Pokémon',
                        labelStyle: const TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.greenAccent,
                            )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(58),
                      primary: Colors.green,
                    ),
                    onPressed: (){
                      if(searchController.text != null && searchController.text.isNotEmpty){
                        setState(() {
                          namePokemon = searchController.text;
                        });
                      }
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: getPokemon(),
                  builder: (context,snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          width: 200,
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
                            width: 200,
                            height: 200,
                            alignment: Alignment.center,
                            child: Column(
                              children: const [
                                Icon(Icons.error),
                                Text("Nenhum pokémon encontrado com o nome digitado"),
                              ],
                            ),
                          );
                        } else{
                          poke = Pokemon.fromApi(snapshot);
                          return createDataPokemon(context,poke);
                        }
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
