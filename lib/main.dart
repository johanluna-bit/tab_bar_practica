import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<String> _imageUrlNotifier;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _imageUrlNotifier = ValueNotifier<String>(_generateRandomImageUrl());

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _imageUrlNotifier.value = _generateRandomImageUrl();
      }
    });
  }

  String _generateRandomImageUrl() {
    final random = Random();
    final widthAnsHeight = 100 + random.nextInt(100);  // Random width between 200 and 500
    return 'https://picsum.photos/$widthAnsHeight';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(100),
      appBar: AppBar(
        title: Text('TabBar Images App'),
          centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.image), text: 'Random 1'),
            Tab(icon: Icon(Icons.image), text: 'Random 2'),
            Tab(icon: Icon(Icons.image), text: 'Random 3'),
          ],
        ),
      ),
      body: TabBarView(

        controller: _tabController,
        children: List.generate(3, (index) => ValueListenableBuilder<String>(
          valueListenable: _imageUrlNotifier,
          builder: (context, imageUrl, child) {
            return ImageScreen(imageUrl: imageUrl);
          },
        )),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  ImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        // This can trigger any action if needed, for now it does nothing
      },
      child: Image.network(imageUrl, fit: BoxFit.scaleDown),
    );
  }
}