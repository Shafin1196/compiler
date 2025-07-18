import 'package:compiler/models/language.dart';
import 'package:compiler/models/output.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  static Future<List<Language>> fetchLanguages() async {
    final response =
        await http.get(Uri.parse('https://emkc.org/api/v2/piston/runtimes'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return Language.listFromJson(jsonList);
    } else {
      throw Exception('Failed to load languages');
    }
  }

  static Future<OutputResult> runCode({
    required Language language,
    required String code,
    required String input,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://emkc.org/api/v2/piston/execute'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'language': language.language,
          'version': language.version,
          "files": [
            {
              "name": getFileName(language.language),
              "content": code,
            }
          ],
          'stdin': input,
          "args": [],
          "compile_timeout": 10000,
          "run_timeout": 3000,
          "compile_memory_limit": -1,
          "run_memory_limit": -1
        }),
      );

      if (response.statusCode == 200) {
        return OutputResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to run code');
      }
    } catch (e) {
      throw Exception('Error occurred while running code: $e');
    }
  }

  static String getFileName(String language) {
    switch (language) {
      case 'python':
      case 'python2':
        return 'main.py';
      case 'javascript':
      case 'node-javascript':
      case 'node-js':
      case 'js':
        return 'main.js';
      case 'typescript':
      case 'deno':
      case 'deno-ts':
      case 'ts':
      case 'node-ts':
      case 'tsc':
        return 'main.ts';
      case 'java':
        return 'Main.java';
      case 'c':
        return 'main.c';
      case 'c++':
      case 'cpp':
      case 'g++':
        return 'main.cpp';
      case 'csharp':
      case 'csharp.net':
      case 'c#':
      case 'cs':
        return 'main.cs';
      case 'dart':
        return 'main.dart';
      case 'go':
        return 'main.go';
      case 'kotlin':
        return 'main.kt';
      case 'php':
        return 'main.php';
      case 'ruby':
        return 'main.rb';
      case 'rust':
        return 'main.rs';
      case 'swift':
        return 'main.swift';
      case 'scala':
        return 'main.scala';
      case 'haskell':
        return 'main.hs';
      case 'perl':
        return 'main.pl';
      case 'bash':
      case 'sh':
        return 'main.sh';
      case 'lua':
        return 'main.lua';
      case 'r':
      case 'rscript':
        return 'main.r';
      case 'julia':
        return 'main.jl';
      case 'clojure':
        return 'main.clj';
      case 'fsharp.net':
      case 'fsharp':
      case 'fs':
      case 'fsi':
        return 'main.fs';
      case 'basic':
      case 'basic.net':
        return 'main.bas';
      case 'cobol':
        return 'main.cob';
      case 'fortran':
        return 'main.f90';
      case 'pascal':
        return 'main.pas';
      case 'prolog':
        return 'main.plg';
      case 'matl':
        return 'main.m';
      case 'octave':
        return 'main.m';
      case 'nasm':
      case 'nasm64':
        return 'main.asm';
      case 'sql':
      case 'sqlite3':
        return 'main.sql';
      case 'vlang':
        return 'main.v';
      case 'zig':
        return 'main.zig';
      default:
        throw Exception('Unsupported language: $language');
    }
  }
}
