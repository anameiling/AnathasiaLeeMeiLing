import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:front_end_assessment_anathasia/posts.dart';
import 'package:http/http.dart' as http;

class Repository {
  String uri = 'https://gorest.co.in/public/v1/posts';

  Future getData() async {
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          HttpHeaders.authorizationHeader:
              'Basic acaaf4323718f087063c9532a4212d32ca1e26f8795df8d2248e50d6d418fec7',
        },
      );

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Posts> posts = it.map((e) => Posts.fromJson(e)).toList();
        return posts;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future createData(String user_id, String title, String body) async {
    try {
      final response = await http.post(Uri.parse(uri),
          body: {'user_id': user_id, 'title': title, 'body': body});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future updatePage(
      String id, String user_id, String title, String body) async {
    try {
      final response = await http.put(Uri.parse('$uri/$id'), body: {
        'user_id': user_id,
        'title': title,
        'body': body,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse('$uri/$id'));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
