import 'package:flutter/material.dart';
import 'package:front_end_assessment_anathasia/repository.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final user_idController = TextEditingController();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Page'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: user_idController,
              decoration: const InputDecoration(hintText: 'user_id'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(hintText: 'body'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.createData(
                      user_idController.text,
                      titleController.text,
                      bodyController.text);

                  if (response) {
                    Navigator.popAndPushNamed(context, 'home');
                  } else {
                    throw Exception('Failed to create data');
                  }
                },
                child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}
