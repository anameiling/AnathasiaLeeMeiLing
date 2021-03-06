import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:front_end_assessment_anathasia/posts.dart';
import 'package:http/http.dart' as http;

class Repository {
  String url =
      'https://gorest.co.in/public/v1/posts?access-token=acaaf4323718f087063c9532a4212d32ca1e26f8795df8d2248e50d6d418fec7';

  Future getData() async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentTypeHeader: "application/json",
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
      final response = await http.post(Uri.parse(url), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:
            "Bearer acaaf4323718f087063c9532a4212d32ca1e26f8795df8d2248e50d6d418fec7",
      }, body: {
        'user_id': user_id,
        'title': title,
        'body': body
      });

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
      final response = await http.put(Uri.parse('$url/$id'), headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader:
            "Bearer acaaf4323718f087063c9532a4212d32ca1e26f8795df8d2248e50d6d418fec7",
      }, body: {
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
      final response = await http.delete(
        Uri.parse('$url/$id'),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:
              "Bearer acaaf4323718f087063c9532a4212d32ca1e26f8795df8d2248e50d6d418fec7",
        },
      );

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
