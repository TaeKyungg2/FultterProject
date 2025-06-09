import 'package:flutter/material.dart';
import 'dart:math';

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 234, 255)),
      ),
      home: const MyHomePage(title: 'TaeKyung\'s RSP Game'),
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
  Hand? myHand;
  Hand? comHand;
  Result? result;
  
  void _chooseComRSPText() {
    final random=Random();
    final randomNumber=random.nextInt(3);
    final hand=Hand.values[randomNumber];
    setState(() {
      comHand=hand;
    });
    decideResult();
  }
  void decideResult(){
    if (myHand == null || comHand == null) {
      return;
    }
    final Result result;
    if (myHand == comHand) {
      result = Result.draw;
    } else if ((myHand == Hand.rock && comHand == Hand.scissors) ||
              (myHand == Hand.scissors && comHand == Hand.paper) ||
              (myHand == Hand.paper && comHand == Hand.rock)) {
      result = Result.win;
    } else {
      result = Result.lose;
    }
    setState(() {
      this.result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Com',style: TextStyle(fontSize: 30),),
            Text(comHand?.text ?? '?', style: TextStyle(fontSize: 90)),
            const SizedBox(height: 30,),
            Text(result?.text ?? '?',style:TextStyle(fontSize:30),),
            const SizedBox(height:30,),
            Text('My',style : TextStyle(fontSize:30)),
            const SizedBox(height:30,),
            Text(myHand?.text ?? '?',style:TextStyle(fontSize:150),),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: (){
              setState((){myHand=Hand.rock;});
              _chooseComRSPText();
            },
            child: const Text('🪨', style: TextStyle(fontSize: 30),),
          ),
          const SizedBox(width:16,),
          FloatingActionButton(onPressed: (){setState((){myHand=Hand.scissors;});
          _chooseComRSPText();},
            child: const Text('✂️', style: TextStyle(fontSize: 30),),
          ),
          const SizedBox(width:16,),
          FloatingActionButton(
            onPressed: (){setState((){myHand=Hand.paper;});
            _chooseComRSPText();},
            child:const Text('👋', style: TextStyle(fontSize: 30),),),
        ],
      ),
    );
  }
}
enum Hand{
  rock,
  paper,
  scissors;
  String get text {
    switch (this) {
      case Hand.rock:
        return '🪨';
      case Hand.paper:
        return '👋';
      case Hand.scissors:
        return '✂️';
    }
  }
}
enum Result {
  win,
  lose,
  draw;
  String get text {
    switch (this) {
      case Result.win:
        return 'Win';
      case Result.lose:
        return 'Lose';
      case Result.draw:
        return 'Draw';
    }
  }
}
