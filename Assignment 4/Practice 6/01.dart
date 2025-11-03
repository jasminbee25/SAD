void main(){
    var laptop1 = Laptop(1, "HP", "8GB");
    var laptop2 = Laptop(2, "Dell", "16GB");
    var laptop3 = Laptop(3, "Lenovo", "12GB");

    laptop1.show();
    laptop2.show();
    laptop3.show();
}

class Laptop{
    int id;
    String name;
    String ram;

    Laptop(this.id, this.name, this.ram);

    void show(){
        print("ID: $id, Name: $name, RAM: $ram");
    }
}
