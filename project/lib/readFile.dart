import 'dart:io';
import 'package:path/path.dart' as p;
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

void main() async {
  writeFile('РЫБИНск');
  readFile();
}