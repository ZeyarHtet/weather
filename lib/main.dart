import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Weather(),
    );
  }
}

class Weather extends StatefulWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  // List weatherList = [];
  var icon_url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: const Text(
          "WEATHER",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Image(
                image: AssetImage("images/cloud.jpg"),
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                style: ButtonStyle(),
                onPressed: () async {
                  var response = await http.get(
                    Uri.parse(
                      'https://api.openweathermap.org/data/2.5/weather?q=Mogok&appid=897f90491808edf00d3784208fa3cbb2&units=metric',
                    ),
                    headers : {
                      "X-RapidAPI-Key" : "1155ed61d7mshc2a7a571370e7a6p10e4a0jsnab7893e8cb7e",
                      "X-RapidAPI-Host" : "wft-geo-db.p.rapidapi.com"
                    }
                  );

                  print(">>>>>>>>>>>>>>>>>");
                  print(response.statusCode);
                  print(response.body);
                  var weatherResponse = jsonDecode(response.body);

                  print(weatherResponse['weather'][0]["description"]);
                  print(weatherResponse['main']['temp_max']);
                  print(weatherResponse['sys']['country']);
                  print(weatherResponse['name']);
                  icon_url = weatherResponse["weather"][0]["icon"];

                  setState(() {});
                },
                child: const Text(
                  "Get Weather",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              icon_url == null
                  ? Container()
                  : Image.network(
                      'http://openweathermap.org/img/w/$icon_url.png',
                    ),
              const Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Mogok",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
