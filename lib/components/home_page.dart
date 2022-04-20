import 'dart:async';
import 'dart:convert';
import '../helpers/constants.dart';
import 'gifs_respons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<GifsRespons> fetchImage(String cat) async {
  final response = await http.get(Uri.parse(
      'https://api.giphy.com/v1/gifs/search?api_key=$secretKey&q=$cat&limit=10&offset=0&rating=g&lang=en'));

  if (response.statusCode == 200) {
    return GifsRespons.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load gifs');
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<GifsRespons> futureImage;

  @override
  void initState() {
    super.initState();
    futureImage = fetchImage('cats');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Taya_App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Search Gifs'),
          ),
          body: Column(
            children: [
              TextField(
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter you category',
                ),
                onSubmitted: (String str) {
                  setState(() {
                    futureImage = fetchImage(str);
                  });
                },
              ),
              Expanded(
                child: SizedBox(
                  child: FutureBuilder<GifsRespons>(
                    future: futureImage,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Data> items = snapshot.data!.data!;
                        List<Image> images = [];

                        for (int i = 0; i < items.length; i++) {
                          final image =
                              Image.network(items[i].images!.d480wStill!.url!);
                          images.add(image);
                        }
                        return GridView(
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 3,
                            crossAxisSpacing: 20,
                          ),
                          children: images,
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
