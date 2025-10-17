import 'dart:io';
void main(){
    print(calculateArea(5, 10));
    print(calculateArea());
}
double calculateArea([double length = 1, double width = 1]){
    return length * width;
}
