import 'package:flutter/material.dart';
import 'package:instadownload/view/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../main.dart';

class MyInstaPage extends StatefulWidget {
  const MyInstaPage({super.key});

  @override
  State<MyInstaPage> createState() => _MyInstaPageState();
}

class _MyInstaPageState extends State<MyInstaPage> {
  final fieldText = TextEditingController();
  late final WebViewController controller;
  bool isLoaded = false;
  bool isText = false;
  bool ontabHideGoogleIcon = false;

  int _selectedIndex = 0;


  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  void clearText() {
    fieldText.clear();
    setState(() {
      isLoaded = false;
      controller = WebViewController();
      controller.goBack();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
       controller = WebViewController()
        ..loadRequest(
          Uri.parse('https://instagram.com'),
        );
  }

  void verifyText(value) {
    if (value == "") {
      setState(() {
        ontabHideGoogleIcon = false;
        isLoaded = true;
        fieldText.value = value;
        fieldText.text = "https://google.com";
      });
      controller = WebViewController()
        ..loadRequest(
          Uri.parse('https://google.com'),
        );
    } else {
      setState(() {
        ontabHideGoogleIcon = false;
        isLoaded = true;
        fieldText.text = "https://google.com/search?q=${value}";
      });
      controller = WebViewController()
        ..loadRequest(
          Uri.parse('https://google.com/search?q=${value}'),
        );
    }
  }


  void _onTabBottonNavItem(value) {
     setState(() {
      _selectedIndex = value;
    });
    switch (value) {
      case 0:
        controller.goBack();
        break;
        case 1:
        controller.goForward();
        break;
        case 2:
         Navigator.push(
          context,
          MaterialPageRoute(
              builder: (contextkkk) => const MyMainPage()));
        break;
      default:
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        height: 40,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 30, 30, 30),
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: fieldText,
            style: const TextStyle(color: Colors.white),
            onSubmitted: (value) => {verifyText(value)},
            onTap: () {
              setState(() {
                ontabHideGoogleIcon = true;
                isText = true;
              });
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 7, 0, 0),
                prefixIcon: ontabHideGoogleIcon
                    ? null
                    : const Image(image: AssetImage('images/google.png')),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: clearText,
                ),
                // : const EdgeInsets.fromLTRB(2,0,0,0),
                hintStyle: const TextStyle(color: Colors.white),
                hintText: 'Search or enter website name',
                border: InputBorder.none),
          ),
        ),
      )),
      body:  WebViewStack(controller: controller), 
     bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 34, 32, 32),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              label: "back",
              backgroundColor: Color.fromARGB(255, 34, 32, 32),
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
              label: 'forward',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
              label: 'Home',
              backgroundColor: Colors.pink,
            ),
            
          ],
          currentIndex: _selectedIndex,
          onTap: (value) => {
          _onTabBottonNavItem(value)
          }        ),
    );
  }
}
