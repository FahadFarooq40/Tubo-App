class ToDo {
  String id;
  String todoText;
  bool isDone;
  DateTime? dueDate; // New field to store the due date of the task

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
    this.dueDate, // Initialize with null
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '01',
        todoText: 'Morning Exercise',
        isDone: true,
        dueDate: DateTime.now()
            .add(const Duration(days: 1)), // Example due date: tomorrow
      ),
      ToDo(
        id: '02',
        todoText: 'Buy Groceries',
        isDone: true,
        dueDate: DateTime.now()
            .add(const Duration(days: 2)), // Example due date: 2 days from now
      ),
      ToDo(
        id: '03',
        todoText: 'Check Emails',
        dueDate: DateTime.now()
            .add(const Duration(days: 3)), // Example due date: 3 days from now
      ),
      ToDo(
        id: '04',
        todoText: 'Team Meeting',
        dueDate: DateTime.now()
            .add(const Duration(days: 4)), // Example due date: 4 days from now
      ),
      ToDo(
        id: '05',
        todoText: 'Work on mobile apps for 2 hours',
        dueDate: DateTime.now()
            .add(const Duration(days: 5)), // Example due date: 5 days from now
      ),
      ToDo(
        id: '06',
        todoText: 'Dinner with Sir/Madam',
        dueDate: DateTime.now()
            .add(const Duration(days: 6)), // Example due date: 6 days from now
      ),
    ];
  }
}
