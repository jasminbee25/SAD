import 'dart:io';
void main(){
    createUser("Jasmin", 22);
    createUser("Halima", 24, false);
}
void createUser(String name, int age, [bool isActive = true]){
    print("Name: $name, Age: $age, Active: $isActive");
}
