import 'dart:io';
void main(){
    stdout.write('Enter first number: ');
    int a = int.parse(stdin.readLineSync()!);
    
    stdout.write('Enter last number: ');
    int b = int.parse(stdin.readLineSync()!);
    
    int res = a ~/ b;
    int rem = a % b;
    
    print("Quotient : $res \nReminder : $rem");
}
