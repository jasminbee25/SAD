import 'dart:io';
void main(){
    for(int num=1;num<=9;num++){
        print('Table of $num:');
        for(int i=1; i<=10; i++){
            print('$num * $i = ${num * i}');
        }
        print('');//empty line between tables
    }
}
