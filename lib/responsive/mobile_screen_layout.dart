// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:instagram_clone/providers/user_provider.dart';
// import 'package:provider/provider.dart';
import '../models/user.dart' as model;

import '../main.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
int page = 0;
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
  }

  onPageChanged(int page){
    setState(() {
      page = page;
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

    // model.User user = Provider.of<UserProvider>(context).getUser;


    return Scaffold(

     bottomNavigationBar: BottomNavigationBar(
       backgroundColor: mobileBackgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            // activeIcon: Icon(Icons.home_outlined , color: Colors.white),
            label: 'Home',
            icon: Icon(Icons.home),
            // backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            // activeIcon: Icon(Icons.search_outlined , color: Colors.white),
            label: 'Search',
            icon: Icon(Icons.search),
            // backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            // activeIcon: Icon(Icons.add_circle_rounded , color: Colors.white),
            label: 'Add',
            icon: Icon(Icons.add_circle),
            // backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            // activeIcon: Icon(Icons.favorite_outlined , color: Colors.white),
            label: 'Likes',
            icon: Icon(Icons.favorite),
            // backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            // activeIcon: Icon(Icons.person_pin_outlined , color: Colors.white),
            label: 'Account',
            icon: Icon(Icons.person),
            // backgroundColor: primaryColor,
          ),
        ],
       selectedIconTheme: const IconThemeData(color: primaryColor),
       unselectedIconTheme: const IconThemeData(color: secondaryColor ,size: 20),
       onTap: navigationTapped,
       // selectedLabelStyle: const TextStyle(color: Colors.yellow, ),
       showUnselectedLabels: false,
         showSelectedLabels: false,
     ),
        body: PageView(
          children: homeScreenItems,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,

        ),

        // body: Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children:  [
        //    Center(child: Text(user.username)),
        //
        //     Center(
        //       child: IconButton(onPressed:() {
        //         navigateToMyApp(context);
        //       },
        //         icon: const Icon(Icons.arrow_back) , color: primaryColor,),
        //     ),
        //         ]
        //     ),
    );
  }
}
