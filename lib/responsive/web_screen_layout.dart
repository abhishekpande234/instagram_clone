import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/global_variables.dart';

import '../main.dart';
import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {

  int _page = 0;
/*  Storing some data from Firebase Document into variable*/
// String username = "";
  // @override
  // void initState(){
  //   super.initState();
  //   getUsername();
  // }

  //Getting Data from FireStore Database
  // void getUsername() async{
  //   DocumentSnapshot snap = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
  //
  //   // print(snap.data());
  //
  //   setState((){
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }
/*  Storing some data from Firebase Document into variable*/
  late PageController pageController;



  @override
  void initState(){
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  navigationTapped(int page){
    if(page==5) {
      page = 0;
    }
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  void navigateToMyApp(context){
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/insta.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigationTapped(0);
            },
            icon: Icon(Icons.home),
            color: _page == 0 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () {navigationTapped(1);},
            icon: const Icon(Icons.search),
            color: _page == 1? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () {navigationTapped(2);},
            icon: const Icon(Icons.add_a_photo),
            color: _page == 2 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () {navigationTapped(3);},
            icon: const Icon(Icons.favorite),
            color: _page == 3 ? primaryColor : secondaryColor,
          ),
          IconButton(
            onPressed: () {navigationTapped(4);},
            icon: const Icon(Icons.person),
            color: _page == 4 ? primaryColor : secondaryColor,
          )
        ],
      ),
      body:  PageView(
        physics: const NeverScrollableScrollPhysics(),
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),

    );
  }
}
