import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const baseUrl = "https://jsonplaceholder.typicode.com/posts";

  // get
  static Future<List> getData() async {
    final res = await http.get(Uri.parse(baseUrl));
    return jsonDecode(res.body);
  }

  // post
  static Future createData(Map data) async {
    return http.post(Uri.parse(baseUrl), body: data);
  }

  // put
  static Future updateData(int id, Map data) async {
    return http.put(Uri.parse("$baseUrl/$id"), body: data);
  }

  // patch
  static Future patchData(int id, Map data) async {
    return http.patch(Uri.parse("$baseUrl/$id"), body: data);
  }

  // delete
  static Future deleteData(int id) async {
    return http.delete(Uri.parse("$baseUrl/$id"));
  }
}
