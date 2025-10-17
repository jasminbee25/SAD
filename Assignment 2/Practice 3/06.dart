import 'dart:math';
void main(){
    print(reverseString("Jasmin"));
}
String reverseString(String text){
    return text.split('').reversed.join();
}
