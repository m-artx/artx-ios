import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'intro_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'side_menu.dart';
import 'font_util.dart';
import 'package:provider/provider.dart';
import 'service/users_model.dart';
import 'service/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsersModel()),
        Provider(create: (context) => ProductService()),
      ],
      child: MaterialApp(
        home: IntroScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _currentPageNotifier = ValueNotifier<int>(0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 23, 23),
      appBar: CustomAppBar(),
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
              child: CarouselSlider.builder(
                itemCount: 4,
                itemBuilder: (context, index, realIdx) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/wideimage${index + 1}.jpeg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  height: 180.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    _currentPageNotifier.value = index;
                  },
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CirclePageIndicator(
                  selectedDotColor: Colors.white,
                  dotColor: Colors.grey,
                  itemCount: 4,
                  currentPageNotifier: _currentPageNotifier,
                )
              ],
            ),
            SizedBox(height: 60),
            Text(
              '인기 있는 작가님',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: getFontFamily('인기 작품'),
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider.builder(
              itemCount: 6,
              itemBuilder: (context, index, realIdx) {
                return AspectRatio(
                  aspectRatio: 1/2,
                  child: Image.asset(
                    'assets/images/image${index + 1}.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
              options: CarouselOptions(
                height: 200,
                viewportFraction: 0.3,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                initialPage: 0,
                onPageChanged: null,
              ),
            ),
            SizedBox(height: 60),
            Text(
              '주목할만한 작가님',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: getFontFamily('추천 작품'),
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider.builder(
              itemCount: 4,
              itemBuilder: (context, index, realIdx) {
                return AspectRatio(
                  aspectRatio: 1/2,
                  child: Image.asset(
                    'assets/images/recommended${index + 1}.jpeg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
              options: CarouselOptions(
                height: 200,
                viewportFraction: 0.3,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                initialPage: 0,
                onPageChanged: null,
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
