import 'dart:io';

void main() {
  stdout.write('Enter a number: ');
  int x = int.parse(stdin.readLineSync()!);
  print('Square = ${x * x}');
}
