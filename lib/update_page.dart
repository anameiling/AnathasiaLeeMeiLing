import 'package:flutter/material.dart';
import 'package:front_end_assessment_anathasia/repository.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final user_idController = TextEditingController();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      user_idController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      titleController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      bodyController.text = args[3];
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Page'),
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
                  bool response = await repository.updatePage(
                      args[0],
                      user_idController.text,
                      titleController.text,
                      bodyController.text);

                  if (response) {
                    Navigator.popAndPushNamed(context, 'home');
                  } else {
                    throw Exception('Failed to update data');
                  }
                },
                child: const Text('Update')),
          ],
        ),
      ),
    );
  }
}
