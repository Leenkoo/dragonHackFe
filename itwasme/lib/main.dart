// Flutter code sample for material.Card.2

// This sample shows creation of a [Card] widget that can be tapped. When
// tapped this [Card]'s [InkWell] displays an "ink splash" that fills the
// entire card.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'dart:convert';
import 'package:gradient_widgets/gradient_widgets.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(fontFamily: 'RobotoMono'),
    home: new ItWasMe(),
  ));
}

class ItWasMe extends StatefulWidget {
  @override
  ItWasMeState createState() {
    return new ItWasMeState();
  }
}

class ItWasMeState extends State<ItWasMe> {

  int counter = 0;
  List<String> strings = ['Flutter', 'is', 'cool', "and","awesome!"];
  String displayedString = "Hello World!";

  Map data;
  String _id = "0";
  String _percentages = "0";
  String _room = "room1";
  String _lifetimeResets = "0";

  Future getData() async {
    http.Response response = await http.get("https://6c68e4ab.ngrok.io/v1/paper/17");
    data = json.decode(response.body);

    debugPrint("body: " + response.body);

    setState(() {
      _percentages = data['percentile'].toString();
      _id= data['id'].toString();
      _room = data['room'].toString();
      _lifetimeResets = data['lifetimeResets'].toString();
      currentImage();
      print("$_id, $_percentages, $_lifetimeResets");
    });

  }

  void resetPercentages() {
    print("rfv $_percentages");
    setState(() {
      _percentages = "0";

    });
    print("rfv2 $_percentages");
  }

  void setPercentages() {
    print("fv $_percentages");
    setState(() {
      _percentages = "100";

    });
    print("fv2 $_percentages");
  }

 Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => getData());
   getData();
  }
  void onPressOfButton() {
    setState(() {
      displayedString = strings[counter];
      counter = counter < 4 ? counter + 1 : 0;
    });
  }
  String _currentImage = "assets/fullRolca.png";
  void currentImage() {
    int perc = int.parse(_percentages);
    if (perc >= 75) {
      _currentImage =  "assets/rollingRolca.png";
    }
    else if (perc < 75 && perc >= 50) {
      _currentImage =  "assets/fullRolca.png";
    }else if (perc < 50 && perc >= 25) {
      _currentImage =  "assets/rollingRolca2.png";
    }else {
      _currentImage =  "assets/emptyRolca2.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("It Was Me"),
        backgroundColor: Color.fromARGB(0xFF, 2, 129, 236)
      ),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container (
                height: 1,
              ),
              new Container(
                child: new Center(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: new CircularGradientButton(
                          child:  Image.asset(
                            'assets/rolca.png',
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                          callback: resetPercentages,
                          gradient: Gradients.rainbowBlue,
                          increaseWidthBy: 40,
                          increaseHeightBy: 40,
                          //shapeRadius: BorderRadius.circular(40.0),

                        ),
                      ),
                      new SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: new CircularGradientButton(
                          child:  Image.asset(
                            'assets/rolca.png',
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                          callback: resetPercentages,
                          gradient: Gradients.rainbowBlue,
                          increaseWidthBy: 40,
                          increaseHeightBy: 40,
                          //shapeRadius: BorderRadius.circular(40.0),

                        ),
                      ),
                      new SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: new CircularGradientButton(
                          child:  Image.asset(
                            'assets/rollingRolca2.png',
                            width: 40,
                            height: 40,
                            color: Colors.white,
                          ),
                          callback: resetPercentages,
                          gradient: Gradients.rainbowBlue,
                          increaseWidthBy: 40,
                          increaseHeightBy: 40,
                          //shapeRadius: BorderRadius.circular(40.0),

                        ),
                      ),
                      new SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: new CircularGradientButton(
                          child:  Image.asset(
                            'assets/emptyRolca2.png',
                            width: 40,
                            height: 40,
                            color: Colors.white,
                          ),
                          callback: resetPercentages,
                          gradient: Gradients.rainbowBlue,
                          increaseWidthBy: 40,
                          increaseHeightBy: 40,
                          //shapeRadius: BorderRadius.circular(40.0),

                        ),
                      ),
                    ],
                  ),
                ),
              ),

               new Container(
                 child: new Center(
                   child: new Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        '$_room',
                        style: TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          color: Colors.black
                        ),
                      ),

                      new Image.asset(
                        '$_currentImage',
                        width: 200,
                        height: 200,
                        color: Colors.black,
                      ),
                    ],
                   ),
                 ),
               ),

              new Container(
                child: new Center(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        "$_percentages %",
                        style: TextStyle(
                            fontSize: 52,
                            shadows: [
                              Shadow(color: Colors.grey, offset: Offset(1, 2), blurRadius: 2)
                            ]
                        ),
                        textAlign: TextAlign.center,
                      ),

                      new Text (
                        '/ $_lifetimeResets',
                        style: TextStyle(
                          fontSize: 52,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              new Container(
                child: new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new SizedBox(
                         height: 70.0,
                         width: 400.0,
                         child: new GradientButton(
                               child:  new Text(
                                 "New paper roll",
                                 style: new TextStyle(
                                   color: Colors.white,
                                   fontSize: 18,
                                 ),
                               ),
                               callback: setPercentages,
                               gradient: Gradients.rainbowBlue,
                           increaseWidthBy: 310,
                           increaseHeightBy: 40,
                           shapeRadius: BorderRadius.circular(40.0),
                         ),
                      ),

                      new Container(
                        height: 10.0,
                      ),

                      new SizedBox(
                         height: 70.0,
                         width: 400.0,
                         child: new GradientButton(
                               child:  new Text(
                                 "Changed",
                                 style: new TextStyle(
                                     color: Colors.white,
                                     fontSize: 18),
                               ),
                               callback: resetPercentages,
                               gradient: Gradients.rainbowBlue,
                           increaseWidthBy: 310,
                           increaseHeightBy: 40,
                           shapeRadius: BorderRadius.circular(40.0),

                         ),
                      ),
                      new Container(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

