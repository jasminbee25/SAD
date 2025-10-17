import 'dart:math';
void main(){
    print(isEven(8));//true
    print(isEven(7));//false
}
bool isEven(int n){
    return n % 2 == 0;
}
