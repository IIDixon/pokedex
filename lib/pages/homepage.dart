import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final searchController = TextEditingController();
  final search = "https://pokeapi.co/api/v2/pokemon/";
  String? namePokemon;

  Future<Map> getPokemon() async{
    http.Response response;

    if(namePokemon == null || searchController.text.isEmpty){
      response = await http.get(Uri.parse(search + "squirtle"));
    } else{
      response = await http.get(Uri.parse(search + namePokemon!));
    }
    return json.decode(response.body);
  }

  void setPokemon(String text){
    setState(() {
      namePokemon = text;
    });
  }

 Widget createDataPokemon(BuildContext context, AsyncSnapshot snapshot){
    final url = snapshot.data!["sprites"]["other"]["official-artwork"]["front_default"];
    final hp = snapshot.data!["stats"][0]["base_stat"];
    final attack = snapshot.data!["stats"][1]["base_stat"];
    final defense = snapshot.data!["stats"][2]["base_stat"];
    //final attackSpecial = snapshot.data!["stats"][3]["base_stat"];
    //final defenseSpecial = snapshot.data!["stats"][4]["base_stat"];
    final speed = snapshot.data!["stats"][5]["base_stat"];
    String element = snapshot.data!["types"][0]["type"]["name"];
    String name = snapshot.data!["name"];

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                )
              ),
              height: 300,
              child: Image.network(url, fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                ),
               ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(name.toUpperCase(), style: const TextStyle(color: Colors.green, fontSize: 22,),textAlign: TextAlign.center,),
                ),
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
                        Text("HP - $hp", style: const TextStyle(fontSize: 22, color: Colors.green ),)
                      ],
                  ),
                  const SizedBox(width: 80,),
                  Column(
                    children: [
                      const Icon(Icons.speed, color: Colors.blueAccent, size: 40,),
                      Text("Speed - $speed", style: const TextStyle(fontSize: 22, color: Colors.green),)
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Container(
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
                        const FaIcon(FontAwesomeIcons.fire, color: Colors.deepOrange, size: 38,),
                        Text("Attack - $attack", style: const TextStyle(fontSize: 22, color: Colors.green),)
                      ],
                    ),
                    const SizedBox(width: 80,),
                    Column(
                      children: [
                        const FaIcon(FontAwesomeIcons.shield, color: Colors.brown, size: 38),
                        Text("Defense - $defense", style: const TextStyle(fontSize: 22, color: Colors.green),)
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 1,bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Element - ", style: const TextStyle(fontSize: 26, color: Colors.green),),
                      Text(element.toUpperCase(), style: const TextStyle(fontSize: 26, color: Colors.green),),
                    ],
                  ),
                ),
              ),
            )
          ],
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: setPokemon,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Pokémon',
                      labelStyle: TextStyle(
                        color: Colors.green,
                        fontSize: 22,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
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
                    setState(() {
                      namePokemon = searchController.text;
                    });
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
                        //return Image.network(snapshot.data!["sprites"]["other"]["official-network"]["front_default"]);
                        return createDataPokemon(context,snapshot);
                      }
                  }
                }
              ),
            )
          ],
        ),
      )
    );
  }
}
