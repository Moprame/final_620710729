import 'dart:async';
import 'dart:io';
import 'package:final_620710729/models/Game.dart';
import 'package:final_620710729/service/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Game>? game_list;
  int count = 0;
  int wrong = 0;
  String message = "";

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    List list = await Api().fetch('quizzes');
    setState(() {
      game_list = list.map((item) => Game.fromJson(item)).toList();
    });
  }

  void guess(String choice) {
    setState(() {
      if (game_list![count].choice_list[game_list![count].answer] == choice) {
        message = "เก่งมากค่ะ";
      } else {
        message = "ยังไม่ถูกลองใหม่นะ";
      }
    });
    Timer timer = Timer(Duration(seconds: 2), () {
      setState(() {
        message = "";
        if (game_list![count].choice_list[game_list![count].answer] == choice) {
          count++;
        } else {
          wrong++;
        }
      });
    });
  }

  Widget printGuess() {
    if (message.isEmpty) {
      return SizedBox(height: 20, width: 10);
    } else if (message == "เก่งมากค่ะ") {
      return Text(message);
    } else {
      return Text(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: game_list != null && count < game_list!.length-1
          ? buildQuiz()
          : game_list != null && count == game_list!.length-1
          ? buildTryAgain()
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildTryAgain() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('End Game'),
            Text('ทายผิด ${wrong} ครั้ง'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    wrong = 0;
                    count = 0;
                    game_list = null;
                    _fetch();
                  });
                },
                child: Text('New Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildQuiz() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(game_list![count].image_url, fit: BoxFit.cover),
            Column(
              children: [
                for (int i = 0; i < game_list![count].choice_list.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                guess(game_list![count].choice_list[i].toString()),
                            child: Text(game_list![count].choice_list[i]),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            printGuess(),
          ],
        ),
      ),
    );
  }
}