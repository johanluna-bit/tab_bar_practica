import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const TabBarExample(),
    );
  }
}

class TabBarExample extends StatefulWidget {
  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TabBarExampleState extends State<TabBarExample>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.cyan,
      appBar: AppBar(
        title: const Text('APIs para Imagenes'),
        centerTitle: true,

        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.adb),
              child: Text("Paul Jarvis"),
            ),
            Tab(
              icon: Icon(Icons.adb),
              child: Text("Random"),
            ),
            Tab(
              icon: Icon(Icons.ac_unit),
              child: Text("Snow"),

            ),
          ],
        ),
      ),
      body:
      TabBarView(
        controller: _tabController,
        children:  <Widget>[

          Center(
            child: Image.network('https://picsum.photos/400/400'),
          ),
          Center(
            child: Image.network('https://picsum.photos/400/400'),
          ),
          Center(
            child: Image.network('https://picsum.photos/400/400'),

          ),
        ],
      ),
    );
  }
}


