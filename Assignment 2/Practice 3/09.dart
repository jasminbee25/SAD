import 'dart:math';
void main(){
    print(maxNumber(10, 25,15));
}
int maxNumber (int a, int b, int c){
    if(a >= b && a>= c) return a;
    else if(b >= a && b >= c) return b;
    else return c;
    
}
