import 'package:flutter/material.dart';
import 'dart:async';
import 'DailyQuoteApp.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DAILY QUOTES APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MyHomePage(title: 'DAILY QUOTES APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  bool showContainer = false;
  @override
  void initState()
  {
    super.initState();
    /*
    Future.delayed(Duration(seconds: 3), ()
    {
      setState(()
      {
        showContainer = true;
      });
    });
     */
    Future.delayed(Duration(seconds: 6), ()
    {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DailyQuoteApp(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/image/logo.JPG'),
              radius: 90,
            ),
            Container(
              height: 20,
            ),
            // if(showContainer)
              Container(
                child: Text(
                  'DAILY QUOTES APP',
                  style: TextStyle(
                    fontFamily: 'MainFont',
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SpinKitWave(
                  color: Colors.white,
                  size: 50.0
                    ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}