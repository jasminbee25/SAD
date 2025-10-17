import 'dart:io';
void main(){
    stdout.write('Enter a number: ');
    String ch = stdin.readLineSync()!.toLowerCase();
    if (ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u'){
        print('$ch is a vowel');
    }else{
        print('$ch is a consonant');
    }
}
