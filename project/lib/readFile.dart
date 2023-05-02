import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:convert';
import 'dart:async';
//запись в текстовый файл
void writeFile (var lineToWrite) async {
  var filePath = p.join(Directory.current.path, 'assets', 'ct.txt');
  File file = File(filePath);
//приводим в общий вид
  late var lowerLineToWrite = lineToWrite.toLowerCase().trim().replaceAll('ё', 'е');

  await file.writeAsString('\n$lowerLineToWrite', mode: FileMode.append);
}
//чтение текстового файла
void readFile () async {
  var filePath = p.join(Directory.current.path, 'assets', 'ct.txt');
  File file = File(filePath);

  var fileContent = await file.readAsString();
//приводим в общий вид
  late var lowerFileContent = fileContent.toLowerCase().trim().replaceAll('ё', 'е');
  print(lowerFileContent);
}

moveUsedWords (var list1, var list2, var place) {
  list1.add(list2[place]);
  return list1;
}

void main() async {
  var cityNames = ['краснодар', 'ростов', 'москва', 'новосибирск', 'армавир'];
  var compName = 'краснодар';
  var userName = 'ростов';
  var usedNames = [];

  print('enter the city');

  var choice = stdin.readLineSync(encoding: utf8)!;

  print('your choice is $choice');

  var lenghtCompName = compName.length;

    if (choice[0] != compName[lenghtCompName - 1]) {
      print('enter the city');
    } else{
      print('good job');
    }

    var check = cityNames.indexOf(choice, 0);

    if (check != -1) {
      print('good job');
    } else{
      print('a city like this doesnt exist');
    }


    print(moveUsedWords(usedNames, cityNames, check));



  // while(tr) {
  //   var lenghtCompName = compName.length;
  //
  //   if (userName[0] != compName[lenghtCompName - 1]) {
  //     print('enter the city');
  //     break;
  //   } else{
  //     print('good job');
  //   }
  //
  //   var check = cityNames.indexOf(userName, 0);
  //
  //   if (check != -1) {
  //     print('good job');
  //   } else{
  //     print('a city like this doesnt exist');
  //     break;
  //   }
  //
  // }



  // writeFile('РЫБИНск');
  // readFile();
}