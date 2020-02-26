import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hi');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Learn About StarWars Characters!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget detailButton(String label, String detailResult) {
    return MaterialButton(
      child: Text(label),
      onPressed: () {
        if (detailResult != null) {
          detail = label + ": " + detailResult;

        }
        setState(() {});
      },
    );
  }

  Widget allDetailButtons() {
    if (dataFound != null && dataFound) {
      return Column(
        children: <Widget>[
          detailButton("name", name),
          detailButton("height", height),
          detailButton("weight", weight),
          detailButton("hair color", hairColor),
          detailButton("eye color", eyeColor),
          detailButton("birth year", birthYear),
          detailButton("gender", gender)

        ],
      );
    } else {
      return Column();
    }
  }



  int x=1;

  String info = "What do you want to know?";
  String name;
  String height;
  String weight;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;

  String detail = "";

  dynamic result;

  bool dataFound;



  void fetchData() async {
    var url = "https://swapi.co/api/people/"+ x.toString();
    var response = await http.get(url);
    result = jsonDecode(response.body);
    print(result.toString());
    name = (result["name"]);
    height = (result["height"]);
    weight = (result["mass"]);
    hairColor = (result["hair_color"]);
    skinColor = (result["skin_color"]);
    eyeColor = (result["eye_color"]);
    birthYear = (result["birth_year"]);
    gender = (result["gender"]);
    dataFound = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Click download button to download information for a new character", style: new TextStyle(
              fontWeight: FontWeight.w100,

            )
            ),
            Text(""),
            MaterialButton(
              child: Text('change person', style: new TextStyle(
               fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
              onPressed: ()
              {
                Random random = new Random();
                x = random.nextInt(100);
                print(x);
                detail = "What do you want to know?";
              },

            ),
            Text(""),
            Text(""),
            Text(detail, style: new TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            )),
            Divider(),
            allDetailButtons()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        tooltip: 'Fetch Data',
        child: Icon(Icons.arrow_downward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
