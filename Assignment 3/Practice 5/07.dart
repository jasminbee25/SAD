import 'dart:io';

void main(){
  File file = File('Practice 5/students.csv');

  List<String> students = [
    'Name,Age,Address',
    'Jasmin,22,Sylhet',
    'Hafsa,21,Dhaka',
    'Halima,25,Barishal'
  ];

  file.writeAsStringSync(students.join('\n'));
  print('Students data written to students.csv\n');

  String content = file.readAsStringSync();
  print('Reading students.csv:\n$content');
}
