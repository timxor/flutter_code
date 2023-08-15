
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Widget> createImageWidgetFromNetwork() async {


  // String apiUrl = 'https://example.com/api/endpoint'; // Replace with your API endpoint URL
  String apiUrl = 'http://localhost:5233/api/getimage';

  //       //    http://localhost:5233/api/getimage

  final response = await http.get(Uri.parse(apiUrl));

  // final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return Image.memory(response.bodyBytes);
  } else {
    throw Exception('Failed to load image');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<Widget>? _imageWidget;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _imageWidget = createImageWidgetFromNetwork();
  }


  /*

  Remember to replace 'http://your-backend-api/image' with your actual API URL.

  If you are testing this app in a local environment and your API also is local,
  you may need to use your machine's IP address instead of "localhost" in the
  API URL, as "localhost" or "127.0.0.1" from the perspective of your
  Flutter app will refer to the app itself and not your local machine.

   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<Widget>(
              future: _imageWidget,
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return snapshot.data!;
                }
              },
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}














// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// Future<Widget> createImageWidgetFromNetwork(String url) async {
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     return Image.memory(response.bodyBytes);
//   } else {
//     throw Exception('Failed to load image');
//   }
// }
//
//
//
//
// class RenderImageFromAPI extends StatefulWidget {
//   @override
//   _RenderImageFromAPIState createState() => _RenderImageFromAPIState();
// }
//
// class _RenderImageFromAPIState extends State<RenderImageFromAPI> {
//   Future<Widget>? _imageWidget;
//
//   @override
//   void initState() {
//     super.initState();
//     _imageWidget =
//         createImageWidgetFromNetwork('http://your-backend-api/image');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image From Network'),
//       ),
//       body: Center(
//         child: FutureBuilder<Widget>(
//           future: _imageWidget,
//           builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return snapshot.data!;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//
