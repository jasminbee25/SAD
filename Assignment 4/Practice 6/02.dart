void main(){
    var h1 = House(1, "Blue Villa", 500000);
    var h2 = House(2, "Green Cottage", 600000);
    var h3 = House(3, "White Castle", 800000);

    List<House> houses = [h1, h2, h3];

    for(var house in houses){
        print("ID: ${house.id}, Name: ${house.name}, Price: ${house.price}");
    }
}

class House{
    int id;
    String name;
    double price;

    House(this.id, this.name, this.price);
}
