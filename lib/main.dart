import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/pages/battlepage.dart';
import 'package:pokedex/pages/homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int indexNow = 0;
  final List<Widget> listWidgets = [
    const HomePage(),
    BattlePage()
  ];

  void onTabTapped(int index){
    setState(() {
      indexNow = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text("Pokedex"),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body:  GestureDetector(
            onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);

              if(!currentFocus.hasPrimaryFocus){
                currentFocus.unfocus();
              }
            },
          child: listWidgets[indexNow],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          onTap: onTabTapped,
          currentIndex: indexNow,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.info_outline_rounded), label: "Info Pokémon"),
            BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.chessKnight), label: "Batalha"),
          ],
        ),
      ),
    );
  }
}
