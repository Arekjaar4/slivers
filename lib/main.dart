import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slivers Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Slivers Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();
  var colors = [
    Colors.black,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.yellow,
    Colors.pink,
    Colors.cyan,
    Colors.indigo,
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.grey,
    Colors.lime,
    Colors.teal,
    Colors.white,
    Colors.tealAccent,
    Colors.lightGreen,
    Colors.blueGrey,
  ];


  bodySlivers() {
    var colorsList = colors.map((e) => e).toList();
    var colorsGrid = colors.map((e) => e).toList();
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Grid'),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                color: colorsGrid[index],
              );
            },
            childCount: colorsGrid.length,
          ),
        ),
        const SliverAppBar(
          pinned: true,
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('List'),
          ),
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return Container(
              height: 100,
              color: colorsGrid[index],
            );
          },
          childCount: colorsGrid.length,
        )),
        const SliverAppBar(
          pinned: true,
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Animated List'),
          ),
        ),
        SliverAnimatedList(
            key: _listKey,
            initialItemCount: colorsList.length,
            // Return a widget that is wrapped with a transition
            itemBuilder: (context, index, animation) {
              if (index > colorsList.length) return null;
              var container = Container(
                height: 100,
                color: colorsList[index],
              );
              return SizeTransition(
                sizeFactor: animation,
                child: Card(
                    child: InkWell(
                      onTap: () {
                        SliverAnimatedList.of(context).removeItem(index,
                                (context, animation) {
                              colorsList.removeAt(index);
                              return SizeTransition(
                                  sizeFactor: animation, child: container);
                            });
                      },
                      onDoubleTap: () {
                        var color = colorsList[Random().nextInt(colorsList.length)];
                        colorsList.insert(index, color);
                        SliverAnimatedList.of(context).insertItem(index);
                      },
                      child: container,
                    )),
              );
            })
      ],
    );
  }

  bodyNormal() {
    var colorsList = colors.map((e) => e).toList();
    return Column(children: [
      Expanded(
          child: GridView.count(
          crossAxisCount: 4,
          children:
          List.generate(colorsList.length, (index) {
            return Container(color: colorsList[index],);
          }))),
      Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            itemCount: colorsList.length,
            itemBuilder: /*1*/ (context, i) {
              return Container(height: 100, color: colorsList[i],);
            },
          ))
      ],);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(body: bodySlivers(),
    );
  }
}
