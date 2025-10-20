import 'dart:io';
void main() {
    List<String> friends = ["Ayesha","Jasmin","Halima","Nila","Arbee","Anabhi"];
    var namesStartingWithA = friends.where((name) => name.startsWith('A'));
    print("Friends whose names start with 'A':");
    print(namesStartingWithA);
}
