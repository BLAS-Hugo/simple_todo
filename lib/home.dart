import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _listOfTodo = [];

  String _newTodo = "";

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();

  late FocusNode _textFieldFocusNode;

  @override
  void initState() {
    _textController.addListener(() {
      _onTextFieldValueChanged(_newTodo);
    });

    _textFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _onTextFieldValueChanged(String newValue) {
    developer.log("NEW VALUE = $newValue");
  }

  void _addTodo(String todo) {
    setState(() {
      _listOfTodo.add(todo);
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _listOfTodo.removeAt(index);
    });
  }

  void _showAddDialog() {
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
               SizedBox(
                height: 50,
                child: TextField(
                  focusNode: _textFieldFocusNode,
                  controller: _textController,
                  onTap: () => _textFieldFocusNode.requestFocus(),
                  onChanged: (value) => _newTodo = value,
                  onSubmitted: (value) {
                    _newTodo = value;
                    _textFieldFocusNode.unfocus();
                  },
                  decoration: const InputDecoration(
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
                          _addTodo(_newTodo);
                          Navigator.pop(context);
                          developer.log("CURRENT LIST OF TODOS = $_listOfTodo");//DEBUG TO DELETE
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
          _showAddDialog();
        },
        child: const Icon(
          Icons.add,
          size: 20,
        ),
      ),
    );
  }
}
