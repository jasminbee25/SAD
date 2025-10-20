import 'dart:io';
void main() {
    Map<String, dynamic> person = {
        "name": "Jasmin",
        "address": "Sunamganj",
        "age": 22,
        "country": "Bangladesh"
    };
    
    person["country"] = "France"; // updating country
    
    print("Updated Map:");
    person.forEach((key,value){
        print("$key: $value");
    });
}
