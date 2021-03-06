import 'package:flutter/material.dart';
import 'package:front_end_assessment_anathasia/create_page.dart';
import 'package:front_end_assessment_anathasia/posts.dart';
import 'package:front_end_assessment_anathasia/repository.dart';
import 'package:front_end_assessment_anathasia/update_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        'home': (context) => const HomePage(),
        'create': (context) => const CreatePage(),
        'update': (context) => const UpdatePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Repository repository = Repository();
  List<Posts> listPosts = [];

  getData() async {
    listPosts = (await repository.getData()) as List<Posts>;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('CRUD Flutter'),
      ),
      body: ListView.builder(
        //   itemCount: 2,
        //   itemBuilder: (context, index) {
        //     return ListTile(
        //       leading: Container(
        //         width: 60,
        //         height: 60,
        //         decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           image: DecorationImage(
        //             image: AssetImage('assets/profile.png'),
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //       title: Text('Anathasia Lee'),
        //       subtitle: Text(
        //         'Hello World!',
        //         maxLines: 1,
        //         overflow: TextOverflow.ellipsis,
        //       ),
        //     );
        //   },
        // ),

        itemCount: listPosts.length,
        itemBuilder: (context, index) {
          Posts posts = listPosts[index];
          return InkWell(
            onTap: () {
              Navigator.popAndPushNamed(context, 'update', arguments: [
                posts.id,
                posts.user_id,
                posts.title,
                posts.body
              ]);
            },
            child: Dismissible(
              key: Key(posts.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: const Icon(Icons.delete),
              ),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Delete Data'),
                      content: const Text('Are you sure to delete data?'),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              bool response =
                                  await repository.deleteData(posts.id);

                              if (response) {
                                Navigator.pop(context, true);
                              } else {
                                Navigator.pop(context, false);
                              }
                            },
                            child: const Text('Yes')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('No')),
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/profile.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                title: Text('${posts.user_id} ${posts.title}'),
                subtitle: Text(
                  posts.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, 'create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
