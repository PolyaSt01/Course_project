import 'package:flutter/material.dart';
import "mainscreen.dart";
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
  var userCityName;
  var usedCityName = [];
  var result = '';

  final _controller = TextEditingController();

  _changeName(){
    setState(() => userCityName = _controller.text);
  }

  @override
  void initState() {
    super.initState();
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
                              padding: EdgeInsets.only(top: 0, bottom:0, left:35, right:20),
                              child:
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            //получаем доступ к текстовому файлу и его данным
                                            var assetFileTxt = await rootBundle.loadString('assets/ct.txt');
                                            var fileContent = assetFileTxt.split('\n');

                                            if(_formKey.currentState!.validate()) {
                                              setState(() {
                                                //проверка на повторяемость города пользователя и на совпадение с нашим списком городов
                                                if(fileContent.indexOf(generalView(userCityName), 0) != -1 && usedCityName.indexOf(generalView(userCityName), 0) == -1) {
                                                  if (computersCity != null){
                                                    result = computersCity;

                                                    if (getLastLetter(computersCity) != generalView(userCityName[0])) {
                                                      result = 'Введите город с правильной буквы';
                                                      return;
                                                    }
                                                  }

                                                  usedCityName.add(generalView(userCityName));

                                                  //ищем подходящий город для компьютера
                                                  computersCity = fileContent.firstWhere((element) => element[0] == getLastLetter(generalView(userCityName)) && usedCityName.indexOf(element, 0) == -1, orElse: () => '-1');

                                                  result = computersCity;

                                                  if (computersCity == '-1') {
                                                    result = 'Вы победили';
                                                    return;
                                                  }

                                                  usedCityName.add(computersCity);
                                                } else {
                                                  result = 'Введите другой город';
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
                                      ),

                                      const SizedBox(width: 40,),

                                      TextButton(
                                          onPressed: () async {
                                            final resultButton = await Navigator.pushNamed(context, '/');
                                          },
                                          child: Text('Сдаюсь', style: TextStyle(fontSize: 24, fontFamily: 'Montserrat', color: Color.fromRGBO(0, 0, 0, 0.6)),),
                                          style: TextButton.styleFrom(
                                            fixedSize: const Size(110, 55),
                                          ),
                                      )
                                    ],
                                  ),
                            ),

                          ),

                          const SizedBox(height: 70,),

                          SizedBox(
                            width: 390,
                            child:
                            Text('$result',
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
    )
);
