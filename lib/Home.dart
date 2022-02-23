import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> listOfTodo = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void addTodo(String todo) {
    setState(() {
      listOfTodo.add(todo);
    });
  }

  void removeTodo(int index) {
    setState(() {
      listOfTodo.removeAt(index);
    });
  }

  void showAddDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: const EdgeInsets.all(10),
            children: [
              const SizedBox(
                height: 50,
                child: Center(child: Text("Add a new thing to do !")),
              ),
              const SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your thing to do"),
                ),
              ),
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          addTodo("TODO");
                          Navigator.pop(context);
                          print(listOfTodo); //DEBUG TO DELETE
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        )),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do App"),
      ),
      body: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: const <Widget>[
              SizedBox(
                height: 200,
              ),
            ]),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog();
        },
        child: const Icon(
          Icons.add,
          size: 20,
        ),
      ),
    );
  }
}
