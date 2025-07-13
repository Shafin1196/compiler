import 'package:compiler/models/language.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ApiServices {
  static Future<List<Language>> fetchLanguages() async {
    final response = await http.get(Uri.parse('https://emkc.org/api/v2/piston/runtimes'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return Language.listFromJson(jsonList);
    } else {
      throw Exception('Failed to load languages');
    }
  }

}