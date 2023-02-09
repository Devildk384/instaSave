import 'package:flutter/material.dart';
import 'package:instadownload/view/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Widgets/HomePage.dart';
import 'Widgets/InstaPage.dart';

void main() {
  runApp(const MyApp());
}

const primaryColor = Color(0xFF151026);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const MyMainPage(),
        "/google": (context) => const MyHomePage(),
        "/instagram": (context) => const MyInstaPage(),
      },

    );
  }
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
   final fieldText = TextEditingController();
  late final WebViewController controller;
  int _selectedIndex = 0;
  var selectedItem = '';
  bool isLoaded = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoaded = false;
  }

  void verifyText(value) {
      
    if (value == "") {
      setState(() {
        // ontabHideGoogleIcon = false;
        // isLoaded = true;
        fieldText.value = value;
        fieldText.text = "https://google.com";
      });
      controller = WebViewController()
        ..loadRequest(
          Uri.parse('https://google.com'),
        );
    } else {
      setState(() {
        // ontabHideGoogleIcon = false;
        isLoaded = true;
        fieldText.text = "https://google.com/search?q=${value}";
      });
      controller = WebViewController()
        ..loadRequest(
          Uri.parse('https://google.com/search?q=${value}'),
        );
       
    }
  }

  void clearText() {
    fieldText.clear();
    setState(() {
      
    });
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
         Navigator.of(context)
         .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
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
                    // ontabHideGoogleIcon = true;
                    // isText = true;
                  });
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 7, 0, 0),
                    prefixIcon:
                        const Image(image: AssetImage('images/google.png')),
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
          ),
          actions: [
            PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: Colors.black,
                shadowColor: Colors.grey,
                onSelected: (value) {
                  // your logic
                  setState(() {
                    selectedItem = value.toString();
                  });
                  Navigator.pushNamed(context, value.toString());
                },
                itemBuilder: (BuildContext bc) {
                  return const [
                    PopupMenuItem(
                      value: '/hello',
                      child: Text(
                        "New Tab",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PopupMenuItem(
                      value: '/about',
                      child: Text(
                        "Bookmarks",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PopupMenuItem(
                      value: '/contact',
                      child: Text(
                        "Contact Us",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PopupMenuItem(
                      value: '/contact',
                      child: Text(
                        "Settings",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ];
                })
          ],
        ),
        body: isLoaded ?  WebViewStack(controller: controller,) : Container(
          color: const Color.fromARGB(255, 30, 30, 30),
          // snackBar: SnackBar(content: Text('Double Back to leave')),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  child: TextButton(
                    // padding: EdgeInsets.all(20.0),
                    // hoverColor: Colors.teal,
                    onPressed: () {
                               Navigator.of(context)
                              .pushNamedAndRemoveUntil('/google', (Route<dynamic> route) => false);
                    },
                    // color: Colors.teal,
                    child: const Text(
                      'Google',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: TextButton(
                    // padding: EdgeInsets.all(20.0),
                    // hoverColor: Colors.teal,
                    onPressed: () {
                         Navigator.of(context)
                              .pushNamedAndRemoveUntil('/instagram', (Route<dynamic> route) => false);
                    },
                    // color: Colors.teal,
                    child: const Text(
                      'Instagram',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ]),
        ),
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
              // backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
              // backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tab_unselected),
              label: 'Tab',
              // backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (value) => {
          _onTabBottonNavItem(value)
          }),
      ),
    );
  }
}
