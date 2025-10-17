import 'dart:io';
void main(){
    printEvenNumbers(1,20);
}

void printEvenNumbers(int start, int end){
    for(int i=start; i<=end; i++){
        if(i % 2 == 0){
            print(i);
        }
    }
}
