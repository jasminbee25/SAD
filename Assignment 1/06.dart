import 'dart:io';
void main(){
    stdout.write('First name: ');
    String first = stdin.readLineSync()!;
    
    stdout.write('Last name: ');
    String last = stdin.readLineSync()!;
    print('Full name: $first $last');

}
