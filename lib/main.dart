import 'package:card_swiper/swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swiper Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  static const List<String> categories = [
    'Chilled',
    'Relaxed',
    'Dance',
    'EDM',
    'Classic',
  ];

  static const List<String> albumDetail = [
    'Skin-12',
    'Base-16',
    'Lp1-11',
    'Chain-22',
    'Love-14',
    'Rain-17',
    'Old-20',
    'You-19',
    'Vibes-10',
  ];

  Widget _getTabBarItems({required String text, bool isActive = false}) {
    return Text(
      text,
      style: TextStyle(
        color: isActive ? Colors.black : Colors.black26,
        fontSize: isActive ? 28 : 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildNavigationBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {},
            icon: const Icon(
              Icons.chat_bubble_outline,
              color: Colors.black38,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {},
            icon: const Icon(
              Icons.album_outlined,
              color: Colors.blue,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {},
            icon: const Icon(
              Icons.account_box_outlined,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Artists',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        titleSpacing: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _getTabBarItems(text: 'Albums', isActive: true),
              _getTabBarItems(text: 'Playlists'),
              _getTabBarItems(text: 'Stations'),
            ],
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 50,
            child: ListView(
              padding: const EdgeInsets.only(left: 15),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                for(int i = 0; i < categories.length; i++)
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(7),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.blue,
                          width: 2,
                        )
                    ),
                    child: Text(
                      categories[i],
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Swiper.builder(
              itemCount: 9,
              aspectRatio: 2 / 3,
              depthFactor: 0.1,
              dx: 60,
              dy: 20,
              paddingStart: 32,
              verticalPadding: 32,
              visiblePageCount: 3,
              widgetBuilder: (index) {
                return Card(
                  elevation: 10,
                  color: Colors.red,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/${index + 1}.jpg'),
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              albumDetail[index].split('-')[0],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 50,
                              ),
                            ),
                            Text(
                              '${albumDetail[index].split('-')[1]} songs',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildNavigationBar(context),
    );
  }
}
