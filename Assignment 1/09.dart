import 'dart:io';
void main(){
    String s = "        Jas      _min     _09";
    String txt = "";
    for (int i = 0; i < s.length; i++){
        if(s[i] != " "){
            txt += s[i];
        }
    }
    print(txt);
}    
