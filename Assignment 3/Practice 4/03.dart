import 'dart:io';
void main() {
    List<double> expenses = [];
    
    for(int i=1; i<=5; i++) {
        stdout.write("Enter expense $i: ");
        double amount = double.parse(stdin.readLineSync()!);
        expenses.add(amount);
    }
    double total = expenses.reduce((a, b) => a + b);
    print("Total expense: $total");
}
