import 'package:flutter/material.dart';
import "dart:io";
import "readFile.dart";
import "mainscreen.dart";
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  var userCityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                            if (value!.isEmpty) {
                              return 'Введите город';
                            } else {
                              userCityName = value;
                            };

                          },
                        ),

                        const SizedBox(height: 30,),

                          UnconstrainedBox(
                            child:
                                Container(
                                  alignment: Alignment.center,
                                  width: 360,
                                  child:
                                  ElevatedButton(
                                      onPressed: () {
                                        if(_formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Успешное вычисление'), backgroundColor: Colors.green,)
                                          );
                                          setState(() {
                                            if (!(userCityName.isEmpty)) {
                                              print(userCityName);
                                            };
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
                          Text('Краснодар',
                            style: TextStyle(
                              fontSize: 32,
                              fontFamily: 'Montserrat',
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Image.asset('assets/image/city.png', fit: BoxFit.fitWidth, ),
          ],
        ),
      ),
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
