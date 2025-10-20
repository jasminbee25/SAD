import 'dart:io';

void main() {
  var file = File('hello.txt');
  try {
    file.writeAsStringSync('Jasmin');
    print('Name written to hello.txt');
  } catch (e) {
    print('Error: $e');
  }
}
