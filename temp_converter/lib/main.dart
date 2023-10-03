import 'package:flutter/material.dart';
import 'package:temp_converter/about.dart';
import 'converter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TempConverter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TempConverter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Converter converter = Converter();
  String _textTemp = "Enter a temp";
  bool selected = true;

  /// Updates the temperature string displayed in the interface.
  void _updateTemp() {
    setState(() {
      _textTemp = converter.convertString();
    });
  }

  /// Updates the temperature measurement mode and the displayed temperature string.
  void _updateSwitch(bool value) {
    setState(() {
      selected = value;
      converter.toggle();
      _textTemp = converter.convertString();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _textTemp,
            style: const TextStyle(fontSize: 30),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            width: 400,
            child: TextField(
              style: const TextStyle(fontSize: 30),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input Temp',
              ),
              onChanged: (text) {
                // try to set the model temp
                converter.setTemp((double.tryParse(text) ?? -500.0));
                // update the interface
                _updateTemp();
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Semantics(
              label: 'wen du lable',
              child: const Text(
                '°C',
                style: TextStyle(fontSize: 25),
                semanticsLabel: 'Celsius',
              ),
            ),
            Semantics(
              label: 'Temperature Unit Switch',
              toggled: !selected,
              child: Switch(
                value: selected,
                onChanged: (value) {
                  _updateSwitch(value);
                },
              ),
            ),
            const Text(
              '°F',
              style: TextStyle(fontSize: 25),
              semanticsLabel: 'Fahrenheit',
            ),
          ]),
          Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: OutlinedButton.icon(
                label: const Text('About Temp Converter'),
                icon: Semantics(
                    label: 'info icon', child: const Icon(Icons.info)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ))
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
