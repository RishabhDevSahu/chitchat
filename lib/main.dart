import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';
import 'package:openwhatsappchat/SplashScreen.dart';
import 'package:toast/toast.dart';

import 'aboutpage.dart';
import 'history.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frosted bottom bar',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: MyHomePage(title: 'Click To Chat', mobileNumber: '', countryCode: 'IN',),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title,required this.mobileNumber, required this.countryCode}) : super(key: key);

  final String title;
  final String countryCode;
  final String mobileNumber;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    Colors.green,
    Colors.deepPurple,
    Colors.blue,
    Colors.deepPurple,
    Colors.deepPurple
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 3, vsync: this);
    tabController.animation!.addListener(
          () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green.withOpacity(0.6),
      //   title: Text(widget.title),
      //   elevation: 0,
      //   centerTitle: true,
      // ),
      bottomNavigationBar: FrostedBottomBar(
        opacity: 0.6,
        sigmaX: 5,
        sigmaY: 5,
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white, width: 4),
            insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
          ),
          tabs: [
            TabsIcon(
                icons: Icons.home,
                color: currentPage == 0 ? colors[0] : Colors.white),
            TabsIcon(
                icons: Icons.history,
                color: currentPage == 1 ? colors[1] : Colors.white),
            TabsIcon(
                icons: Icons.person,
                color: currentPage == 2 ? colors[2] : Colors.white),
            // TabsIcon(
            //     icons: Icons.person,
            //     color: currentPage == 3 ? colors[3] : Colors.white),
            // TabsIcon(
            //     icons: Icons.menu,
            //     color: currentPage == 4 ? colors[4] : Colors.white),
          ],
        ),
        borderRadius: BorderRadius.circular(500),

        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controller) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(currentPage == 0){
              return Home(widget.mobileNumber,widget.countryCode);
            }else if(currentPage == 1){
              return History();
            }else if(currentPage == 2){
              return About();
            }else if(currentPage == 3){
              return History();
            }else {
              return History();
            }
          },
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final IconData icons;

  const TabsIcon(
      {Key? key,
        this.color = Colors.white,
        this.height = 60,
        this.width = 50,
        required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icons,
          color: color,
        ),
      ),
    );
  }
}