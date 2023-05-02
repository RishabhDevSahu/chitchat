// import 'package:flutter/material.dart';
// import 'package:openwhatsappchat/history.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
//
// import 'homepage.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   var _currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             if(_currentIndex == 0){
//               return Home();
//             }else if(_currentIndex == 1){
//               return History();
//             }else if(_currentIndex == 2){
//               return History();
//             }else if(_currentIndex == 3){
//               return History();
//             }else {
//               return History();
//             }
//           },
//         ),
//         bottomNavigationBar: SalomonBottomBar(
//           curve: Curves.bounceOut,
//           currentIndex: _currentIndex,
//           onTap: (i) => setState(() => _currentIndex = i),
//           items: [
//             /// Home
//             SalomonBottomBarItem(
//               icon: Icon(Icons.home),
//               title: Text("Home"),
//               selectedColor: Colors.green,
//             ),
//
//             /// Likes
//             SalomonBottomBarItem(
//               icon: Icon(Icons.history),
//               title: Text("History"),
//               selectedColor: Colors.green,
//             ),
//
//             /// Search
//             SalomonBottomBarItem(
//               icon: Icon(Icons.store),
//               title: Text("Status"),
//               selectedColor: Colors.green,
//             ),
//
//             /// Profile
//             SalomonBottomBarItem(
//               icon: Icon(Icons.person),
//               title: Text("Profile"),
//               selectedColor: Colors.green,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }