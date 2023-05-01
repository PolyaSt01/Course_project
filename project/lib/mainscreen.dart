import 'package:flutter/material.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text('Игра в города', style: TextStyle(fontSize: 44, fontFamily: 'Montserrat'),),

                  const SizedBox(height: 45,),

                  ElevatedButton(onPressed: () async {
                    final result = await Navigator.pushNamed(context, '/second');

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$result !'))
                    );
                  },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(240, 207, 101, 1),
                        fixedSize: const Size(186, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Начать', style: TextStyle(fontSize: 24, fontFamily: 'Montserrat', color: Colors.black),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
