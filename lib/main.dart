import 'package:compiler/api_services.dart';
import 'package:compiler/models/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compiler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Language>> languagesFuture;
  Language? selectedLanguage;
  @override
  void initState() {
    super.initState();
    languagesFuture = ApiServices.fetchLanguages();
  }
  void _runcode(){
    setState(() {
      // code to run
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Compiler'),
        elevation: 10,
        shadowColor: Theme.of(context).primaryColor.withOpacity(0.5),
        toolbarHeight: 40,
        actions: [
          FutureBuilder<List<Language>>(
            future: languagesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))),
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error, color: Colors.red);
              } else if (snapshot.hasData) {
                final languages = snapshot.data!;
                return DropdownButtonHideUnderline(
                  child: DropdownButton<Language>(
                    value: selectedLanguage ?? languages.first,
                    dropdownColor: Theme.of(context).canvasColor,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    items: languages.map((lang) {
                      return DropdownMenuItem<Language>(
                        value: lang,
                        child: Text(lang.language, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                      );
                    }).toList(),
                    onChanged: (Language? newLang) {
                      setState(() {
                        selectedLanguage = newLang;
                      });
                    },
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          IconButton(onPressed: _runcode, 
            icon: Icon(Icons.play_arrow,),
          )
        ],
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
      drawer: DrawerButton(),
    );
  }
}