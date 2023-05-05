import 'package:flutter/material.dart';
import "dart:io";
import "readFile.dart";
import "mainscreen.dart";

import 'package:path/path.dart' as p;
import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;


class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

//приводим в общий вид
  generalView (var name) {
    var generalViewName = name.toLowerCase().trim().replaceAll('ё', 'е');
    return generalViewName;
  }
//проверка на буквы ь, ъ, ы, й на конце слова
  getLastLetter (var name) {
    const exceptLetters = ['ъ', 'ь', 'ы', 'й'];
    var lastLatter = name[name.length - 1];

    if(name.length < 1){
      return lastLatter;
    } else if (exceptLetters.indexOf(lastLatter, 0) != -1 && exceptLetters.indexOf(name[name.length - 2], 0) != -1) {
      return name[name.length - 3];
    } else if (exceptLetters.indexOf(lastLatter, 0) != -1) {
      return name[name.length - 2];
    } else {
      return lastLatter;
    }
  }

  var computersCity;
  var userCityName = '';
  var usedCityName = [];

  final _controller = TextEditingController();

  _changeName(){
    setState(() => userCityName = _controller.text);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = userCityName;
    _controller.addListener(_changeName);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.all(0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(25),
                    child:
                    Form(
                      key: _formKey,
                      child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60,),

                          Text('Введите город',
                            style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                            textAlign: TextAlign.left,),

                          const SizedBox(height: 10,),

                          TextFormField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(240, 207, 101, 1)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color.fromRGBO(240, 207, 101, 0.7)),
                                borderRadius: BorderRadius.circular(10),
                              ),

                            ),
                            style: TextStyle(fontSize: 24, fontFamily: 'Montserrat'),
                            validator: (value) {
                              if (value!.isEmpty) return 'Введите город';
                            },
                            controller: _controller,
                          ),

                          const SizedBox(height: 30,),

                          UnconstrainedBox(
                            child:
                            Container(
                              alignment: Alignment.center,
                              width: 360,
                              child:
                              ElevatedButton(
                                  onPressed: () async {

                                    var assetFileTxt = await rootBundle.loadString('assets/ct.txt');
                                    var fileContent = assetFileTxt.split('\n');

                                    if(_formKey.currentState!.validate()) {
                                      setState(() {
                                        if(fileContent.indexOf(generalView(userCityName), 0) != -1 && usedCityName.indexOf(generalView(userCityName), 0) == -1 && usedCityName.indexOf(computersCity, 0) == -1) {

                                          computersCity = fileContent.firstWhere((element) => element[0] == getLastLetter(generalView(userCityName)), orElse: () => 'Вы победили');

                                          if (computersCity == 'Вы победили') {
                                            //print('Вы победили');
                                            return;
                                          }

                                          usedCityName.add(computersCity);

                                          if (getLastLetter(generalView(userCityName)) != computersCity[0]) {
                                            computersCity = 'Введите город с правильной буквы';
                                            //print('введите город с правильной буквы');
                                            return;
                                          }

                                          usedCityName.add(generalView(userCityName));

                                          print(fileContent);
                                          print(usedCityName);

                                        } else if (usedCityName.indexOf(computersCity, 0) == -1) {
                                          computersCity = 'Вы победили';
                                        }
                                        else {
                                          computersCity = 'Введите другой город';
                                          usedCityName.clear();
                                        }
                                      });
                                    };
                                  },

                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromRGBO(240, 207, 101, 1),
                                    fixedSize: const Size(135, 55),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),

                                  child: Text('Ок', style: TextStyle(fontSize: 24, fontFamily: 'Montserrat', color: Colors.black),)
                              ),),

                          ),

                          const SizedBox(height: 70,),

                          SizedBox(
                            width: 390,
                            child:
                            Text('$computersCity',
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),

                  Image.asset('assets/image/city.png', fit: BoxFit.fitWidth, ),
                ],
              ),
            ),
          ],
        )
    );
  }
}

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(BuildContext context) => const MainScreen(),
        '/second':(BuildContext context) => MyForm(),
      },
      // home: Scaffold(
      //   body: MyForm(),
      // ),
    )
);
