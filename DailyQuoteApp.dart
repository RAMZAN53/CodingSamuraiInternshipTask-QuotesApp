import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DailyQuoteApp());
}

class DailyQuoteApp extends StatelessWidget {
  const DailyQuoteApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DAILY QUOTES APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent),
      ),
      home: const MyHomePage(title: 'DAILY QUOTES APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  final String postsUrl ="https://api.adviceslip.com/advice";
  String Quote ="";
  bool flag=false;
  GenerateQuote() async
  {
    var res = await http.get(Uri.parse(postsUrl));
    var result =jsonDecode(res.body);
    print(result["slip"]["advice"]);
    setState(()
    {
      Quote=result["slip"]["advice"];
    });
  }
  ShareQuote() async
  {
    Share.share(Quote);
  }
  CopyQuote()
  {
      Clipboard.setData(ClipboardData(text: Quote));
  }
  Future<void> AddQuote() async
  {
   // print("ADDED");
    final pref = await SharedPreferences.getInstance();
    await pref.setString('Quote::', Quote);
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: 'MainFont',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            backgroundColor: Colors.transparent,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            Container(
              height: 380,
              width: 380,
              /*
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
               */
              child: Center(
                child: Text(
                  Quote,
                  style: TextStyle(
                    fontFamily: 'Quotefont',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height:30,
              width:20,
            ),
            ElevatedButton(onPressed:()
            {
              // print("BUTTON PRESSED");
              GenerateQuote();
            },
              child: Text(
                "Refresh",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
              [
                TextButton(onPressed:()
                {
                  //print("Copy BUTTON PRESSED");
                  CopyQuote();
                },
                  child: Text(
                    "Copy",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),

                TextButton(onPressed:()
                {
                  // print("Share BUTTON PRESSED");
                  ShareQuote();
                },
                    child: Text(
                      "Share",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),)
                ),
                FavoriteButton(
                  iconColor: Colors.red,
                  iconDisabledColor: Colors.blue,
                    isFavorite:false,
                    valueChanged: (_isFavourite)
                        {
                          if(_isFavourite)
                            {
                              //print("FAVORITE :: $_isFavourite");
                              AddQuote();
                              _isFavourite=false;
                              showDialog(
                                  context: context,
                                  builder: (context)
                                  {
                                   return Container(
                                     child: AlertDialog(
                                       title: Text("Quote Saved"),
                                       actions:
                                       [
                                         TextButton(
                                             onPressed: ()
                                             {
                                               setState(()
                                               {
                                                 _isFavourite=false;
                                               });
                                               Navigator.pop(context);
                                             },
                                             child: Text("OK")
                                         ),
                                       ],
                                     ),
                                   );
                                  });
                            }
                        },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: const Text(
          '\t \t \t \t \t \t \t \t \t \t \t  >>> RAMZAN <<<',
          style: TextStyle(
            fontFamily: 'Mainfont',
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        color: Colors.lightBlueAccent,
      ),
      //backgroundColor: Colors.white24,
      backgroundColor: Colors.white10,
      //backgroundColor: Colors.white30,
    );
  }
}