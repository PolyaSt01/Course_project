import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:convert';
import 'dart:async';
import 'dart:math';
//import 'package:flutter/services.dart' show rootBundle;

//запись в текстовый файл
void writeFile (var lineToWrite) async {
  var filePath = p.join(Directory.current.path, 'assets', 'ct.txt');
  File file = File(filePath);
//приводим в общий вид
  late var lowerLineToWrite = lineToWrite.toLowerCase().trim().replaceAll('ё', 'е');

  await file.writeAsString('\n$lowerLineToWrite', mode: FileMode.append);
}

//чтение текстового файла
readFile () async {
  var filePath = p.join(Directory.current.path, 'assets', 'ct.txt');
  File file = File(filePath);

  var fileContent = await file.readAsLines();
//приводим в общий вид
  //late var lowerFileContent = fileContent.toLowerCase().trim().replaceAll('ё', 'е');
  //print(lowerFileContent);
  return fileContent;
}

//проверка на присутствие названного города в списке
isThereCity (var list, var city) {
  var check = list.indexOf(city, 0);
  return check;
}
//приводим в общий вид
generalView (var name) {
  var generalViewName = name.toLowerCase().trim().replaceAll('ё', 'е');
  return generalViewName;
}
//проверка на буквы ь, ъ, ы, й на конце слова
getLastLetter (var name) {
  const exceptLetters = ['ъ', 'ь', 'ы', 'й'];
  var lastLatter = name[name.length - 1];
  //var penultimateLetter = name[name.length - 2];

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

game (var computersCity, var fileContent, var userCityName) {
  while(true) {

    computersCity = fileContent.firstWhere((element) => element[0] == getLastLetter(userCityName), orElse: () => '-1');

    //проверки города компьютера
    if (computersCity == '-1') {
      print('вы победили');
      break;
    }

    fileContent.removeWhere((item) => item == computersCity);

    print('computers city is  ${generalView(computersCity)}');

    //проверки города пользователя
    var checkingUserCityExist = isThereCity(fileContent, userCityName);

    if(checkingUserCityExist == -1){
      print('checking user city exist введите другой город');
      break;
    }

    if (getLastLetter(userCityName) != computersCity[0]) {
      print('введите город с правильной буквы');
      break;
    }


    fileContent.removeWhere((item) => item == userCityName);

    return computersCity;

  }

}

void main () async {
  Random random = Random();

  var filePath = p.join(Directory.current.path, 'assets', 'ct.txt');
  File file = File(filePath);

  var fileContent = await file.readAsLines();

  while(true) {
    print('enter the city');

    var usersCity = stdin.readLineSync(encoding: utf8)!.toLowerCase().trim().replaceAll('ё', 'е');

    //проверки города пользователя
    var checkingUserCityExist = isThereCity(fileContent, usersCity);

    if(checkingUserCityExist == -1){
      print('введите другой город');
      break;
    }

    var computersCity = fileContent.firstWhere((element) => element[0] == getLastLetter(usersCity), orElse: () => '-1');

    generalView(computersCity);

    print('computers city is $computersCity');

    //проверки города пользователя
    if (getLastLetter(usersCity) != computersCity[0]) {
      print('введите город с правильной буквы');
      break;
    }

    //проверки города компьютера
    if (computersCity == '-1') {
      print('вы победили');
      break;
    }

    fileContent.removeWhere((item) => item == computersCity);
    fileContent.removeWhere((item) => item == usersCity);
  }
}