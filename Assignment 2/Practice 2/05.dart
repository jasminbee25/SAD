import 'dart:io';
void main(){
    stdout.write('Enter n: ');
    int n = int.parse(stdin.readLineSync()!);
    int sum = 0;
    for(int i = 1; i <= n; i++){
        sum += i;
    }
    print('Sum = $sum');
}
