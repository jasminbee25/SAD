import 'dart:io';
void main(){
    stdout.write('Enter a number: ');
    double n = double.parse(stdin.readLineSync()!);
    if (n > 0){
        print('$n is positive');
    }else if (n < 0){
        print('$n is negitive');
    }else{
        print('Number is zero');
    }
}
