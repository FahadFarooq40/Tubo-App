import 'package:flutter/material.dart';
import 'package:tobo_app/constants/color.dart';
import 'package:tobo_app/model/tobo.dart';
import 'package:tobo_app/widgets/tobo_items.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: searchBox(),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'All ToDo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                for (ToDo todo in _foundToDo.reversed)
                  ToDoItem(
                    todo: todo,
                    onToDoChanged: _handleToDoChange,
                    onDeleteItem: _deleteToDoItem,
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddToDoDialog(context);
        },
        backgroundColor: tdBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
      _runFilter(_todoController.text); // Update search results after deletion
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
      _runFilter(_todoController.text); // Update search results after addition
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _todoController,
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/image/fahadfarooq.jpg'),
          ),
        ],
      ),
    );
  }

  void _showAddToDoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a new todo item"),
          content: TextField(
            controller: _todoController,
            autofocus: true,
            decoration: InputDecoration(hintText: "Enter your todo"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_todoController.text.isNotEmpty) {
                  _addToDoItem(_todoController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text("Add"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: tdBlue, // text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        );
      },
    );
  }
}
