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
//приводим в общий вид
generalView (var name) {
  var generalViewName = name.toLowerCase().trim().replaceAll('ё', 'е');
  return generalViewName;
}
//проверка на буквы ь, ъ, ы, й на конце слова
getLastLetter (var name) {
  const exceptLetters = ['ъ', 'ь', 'ы', 'й'];
  var lastLatter = name[name.length - 1];

  if(exceptLetters.indexOf(lastLatter, 0) != -1) {
    return name[name.length - 2];
  }
  return lastLatter;
}

void main() {
  Random random = Random();
  var cityNames = ['краснодар', 'ростов', 'москва', 'курск', 'армавир', 'владивосток', 'анапа', 'рыбинск', 'казань', 'нижний новгород', 'дигора'];

  var randomElement = random.nextInt(cityNames.length);
  var computersCity = cityNames[randomElement];

  while(true) {
    generalView(computersCity);

    print('computers city is $computersCity');

    cityNames.removeWhere((item) => item == computersCity);

    print('enter the city');

    var usersCity = stdin.readLineSync(encoding: utf8)!.toLowerCase().trim().replaceAll('ё', 'е');

    var lenghtComputersCity = computersCity.length;
    var lenghtUsersCity = usersCity.length;

    var checkingUserCityExist = isThereCity(cityNames, usersCity);

    cityNames.removeWhere((item) => item == usersCity);

    //проверки города пользователя
    if(checkingUserCityExist == -1){
      print('введите другой город');
      break;
    }

    if (usersCity[0] != getLastLetter(computersCity)) {
      print('введите город с правильной буквы');
      break;
    }

    //проверки города компьютера
    computersCity = cityNames.firstWhere((element) => element[0] == getLastLetter(usersCity), orElse: () => '-1');

    if (computersCity == '-1') {
      print('вы победили');
      break;
    }

    print(cityNames);


  }

  // writeFile('РЫБИНск');
  // readFile();
}