import 'dart:io';
void main(){
    stdout.write('Enter a: ');
    int a = int.parse(stdin.readLineSync()!);
    
    stdout.write('Enter b: ');
    int b = int.parse(stdin.readLineSync()!);
    
    print("Before Swap, A : $a, B : $b");
    
    int temp = a;
    a = b;
    b = temp;
    
    print("After Swap, A : $a, B : $b");
}    
