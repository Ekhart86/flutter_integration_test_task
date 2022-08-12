import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _defaultElevation = 3.0;

  final _inputController = TextEditingController();
  final _defaultShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );

  static final _notes = <String>[];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            widget.email,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                color: Colors.white,
                elevation: _defaultElevation,
                shape: _defaultShape,
                child: Container(
                  height: 140,
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextField(
                          controller: _inputController,
                          cursorColor: Colors.blue,
                          style: const TextStyle(color: Colors.black54),
                          decoration: InputDecoration(
                            hintText: 'Add a note',
                            hintStyle: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                            contentPadding: const EdgeInsets.only(left: 20.0),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: const Text('Clear'),
                              onPressed: () => _inputController.clear(),
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).canvasColor,
                                onPrimary: Colors.black54,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            ElevatedButton(
                              child: const Text('Save'),
                              onPressed: () {
                                setState(() {
                                  if (_inputController.text.isNotEmpty) {
                                    _notes.add(_inputController.text);
                                    _inputController.clear();
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlueAccent,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: _notes.isEmpty
                  ? const Center(
                      child: Text('You do not have any notes yet'),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          elevation: _defaultElevation,
                          shape: _defaultShape,
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _notes.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _notes.removeAt(index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red[400],
                                    ),
                                  ),
                                  title: Text(_notes[index]),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Divider(
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
