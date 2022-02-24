import 'dart:async';

import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, bool>> _listOfTodo = [];

  String _newTodo = "";

  final ScrollController _scrollController = ScrollController();

  late FocusNode _textFieldFocusNode;

  @override
  void initState() {
    _textFieldFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _onTextFieldValueChanged(String newValue) {
    _newTodo = newValue;
  }

  void _addTodo(String todo) {
    setState(() {
      _listOfTodo.add({todo: false});
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
                  onTap: () => _textFieldFocusNode.requestFocus(),
                  onChanged: (value) => _onTextFieldValueChanged(value),
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
                          _textFieldFocusNode.unfocus();
                          Navigator.pop(context);
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
          child: ListView.builder(
            itemCount: _listOfTodo.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Text(_listOfTodo[index].keys.first),
                  trailing: Checkbox(
                    value: _listOfTodo[index][_listOfTodo[index].keys.first],
                   onChanged: (value) {
                     _listOfTodo[index][_listOfTodo[index].keys.first] = value!;
                     setState(() {
                       Timer(const Duration(seconds: 1), () => _removeTodo(index));
                     });
                   },
                  ),
                );
              })
          ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Add a Todo",
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
