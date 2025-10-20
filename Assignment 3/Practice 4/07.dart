import 'dart:io';
void main() {
    Map<String, String> contacts = {
        "John": "01713333333",
        "Lina": "01711111111",
        "Alex": "01722222222",
        "Eva": "01744444444"
    } ;
    var keysWithLength4= contacts.keys.where((key) => key.length == 4);
    print("Keys with length 4:");
    print(keysWithLength4);
}
