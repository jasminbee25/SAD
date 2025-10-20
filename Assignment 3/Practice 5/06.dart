import 'dart:io';

void main() {
  File file = File('hello_copy.txt');
  if (file.existsSync()) {
    file.deleteSync();
    print('hello_copy.txt deleted.');
  } else {
    print('File does not exist.');
  }
}
