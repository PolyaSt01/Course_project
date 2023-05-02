import 'dart:io';
import 'package:path/path.dart' as p;
import 'dart:convert';
import 'dart:async';
import 'dart:math';

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

// //перемещаем названные города в другой список
// moveCityName (var list1, var list2, var place) {
//   list1.add(list2[place]);
//   return list1;
// }

//проверка на присутствие названного города в списке
isThereCity (var list, var city) {
  var check = list.indexOf(city, 0);
  return check;
}

void main() {
  Random random = Random();
  var cityNames = ['краснодар', 'ростов', 'москва', 'новосибирск', 'армавир', 'владивосток', 'анапа', 'красноярск', 'рыбинск', 'тихорецк', 'кисловодск'];
  var usedNames = [];

  var randomElement = random.nextInt(cityNames.length);
  var compName = cityNames[randomElement];

  while(true) {
    print('computers city is $compName');

    cityNames.removeWhere((item) => item == compName);

    print('enter the city');

    var choice = stdin.readLineSync(encoding: utf8)!.toLowerCase().trim().replaceAll('ё', 'е');

    var lenghtCompName = compName.length;
    var lenghtChoice = choice.length;

    var checkingUserCityExist = isThereCity(cityNames, choice);

    var checkingCompCityRepeat = isThereCity(usedNames, compName);
    var checkingCompCityExist = isThereCity(cityNames, compName);

    cityNames.removeWhere((item) => item == choice);

    //проверки города пользователя
    if(checkingUserCityExist == -1){
      print('введите другой город');
      break;
    }

    if (choice[0] != compName[lenghtCompName - 1]) {
      print('введите город с правильной буквы');
      break;
    }

    //проверки города компьютера
    compName = cityNames.firstWhere((element) => element[0] == choice[lenghtChoice - 1], orElse: () => '-1');

    if (compName == '-1') {
      print('вы победили');
      break;
    }

    cityNames.removeWhere((item) => item == choice);

    print(cityNames);

  }



  // writeFile('РЫБИНск');
  // readFile();
}