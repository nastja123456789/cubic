
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cubic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  AnimationController? _controller;
  Animation<Offset>? _animation;
  AnimationController? _controller1;
  Animation<Offset>? _animation1;
  Random random = new Random();
  List<int> gen = [2,4,8,16,32,64];
  String number = '';

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 2),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInCubic,
    ));
    Future.delayed(const Duration(milliseconds: 3000), () {
      _controller!.forward();
    });
    _animation1 = Tween<Offset>(
      begin: const Offset(0.0, 2),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller1!,
      curve: Curves.easeInCubic,
    ));
    Future.delayed(const Duration(milliseconds: 3000), () {
      _controller1!.forward();
    });
  }

  Widget generate() {
    int ind = random.nextInt(5);
    int ret = gen[ind];
    return Text('${ret.toString()}');
    //number = ret.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Center(
            child: SlideTransition(
              position: _animation!,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: generate(),
              ),
            ),
          ),
          Center(
            child: SlideTransition(
              position: _animation1!,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: generate(),
              ),
            ),
          ),
        ],
      )
    );
  }
}
