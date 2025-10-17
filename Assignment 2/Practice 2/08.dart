import 'dart:io';
void main(){
    stdout.write('Enter a number: ');
    double a = double.parse(stdin.readLineSync()!);
    stdout.write('Enter operator (+,-,*,/): ');
    String op = stdin.readLineSync()!;
    stdout.write('Enter second number: ');
    double b = double.parse(stdin.readLineSync()!);
    
    double result;
    if(op == '+'){
        result = a + b;
    }else if(op == '-'){
        result = a - b;
    }else if(op == ' * '){
        result = a * b;
    }else if(op == ' / '){
        result = a / b;
    }else{
        print('Invalid operator');
        return;
    }
    print('Result = $result');
    
}
