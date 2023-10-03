import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final title = TextEditingController();
  final content = TextEditingController();

  Box? notesBox;

  @override
  void initState() {
    notesBox = Hive.box<String>('notes');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ValueListenableBuilder(
        valueListenable: notesBox!.listenable(),
        builder: (BuildContext context, Box<dynamic> notes, _) {
          return ListView.builder(
              itemCount: notesBox!.keys.length,
              itemBuilder: (context, index) {
                final key = notes.keys.toList()[index];
                final value = notesBox!.get(key);
                return ListTile(
                  title: Text(
                    key.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    value.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Column(
                                  children: [
                                    Text('Update Note'),
                                    TextField(
                                      controller: title,
                                      decoration:
                                          InputDecoration(hintText: "Title"),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    TextField(
                                      controller: content,
                                      decoration:
                                          InputDecoration(hintText: "Content"),
                                    )
                                  ],
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.red,
                                    child: Text("cancle"),
                                  ),
                                  MaterialButton(
                                    color: Colors.green,
                                    onPressed: () async {
                                      await notesBox!
                                          .put(title.text, content.text);
                                      Navigator.pop(context);
                                    },
                                    child: Text('update'),
                                  )
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                      IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Do you want to delete this note?"),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.red,
                                    child: Text("No"),
                                  ),
                                  MaterialButton(
                                    onPressed: () async {
                                      await notesBox!.delete(key);
                                      Navigator.pop(context);
                                    },
                                    color: Colors.green,
                                    child: Text("Yes"),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text('Add Note'),
                  TextField(
                    controller: title,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: content,
                    decoration: InputDecoration(hintText: "Content"),
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                  child: Text("Cancle"),
                ),
                MaterialButton(
                  onPressed: () async {
                    print('Title=>${title.text}');
                    print('Content=>${content.text}');
                    await notesBox!.put(title.text, content.text);
                    print('T22222');
                    Navigator.pop(context);
                    print('33333');
                  },
                  color: Colors.green,
                  child: Text('Add'),
                )
              ],
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
