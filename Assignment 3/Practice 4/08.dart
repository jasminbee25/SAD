import 'dart:io';
void main() {
    List<String> tasks = [];
    
    while (true){
        print("\n--- Simple To-Do App---");
        print("1. Add Task");
        print("2. Remove Task");
        print("3. View Task");
        print("4. Exit");
        
        stdout.write("Choose an option: ");
        int choice = int.parse(stdin.readLineSync()!);
        
        if (choice == 1){
            stdout.write("Enter task: ");
            String task = stdin.readLineSync()!;
            tasks.add(task);
            print("Task addes!");
            
        }
        else if (choice == 2){
            stdout.write("Enter task to remove: ");
            String task = stdin.readLineSync()!;
            if(tasks.remove(task)){
                print("Task removed!");
            }else{
                print("Task not found.");
            }    
          }else if (choice == 3){
              
              print("\nYour Tasks:");
              if(tasks.isEmpty){
                print("No tasks added yet.");
              }else{
               for(var task in tasks){
                 print("- $task");
               }
              }
            }else if (choice == 4){
                print("Goodbye!");
                break;
            }else{
                print("Invalid choice. Try again.");
            }
        
    }
}
