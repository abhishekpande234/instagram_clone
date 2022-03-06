

import 'package:flutter/material.dart';
import 'package:instagram_clone/main.dart';
import 'package:instagram_clone/utils/colors.dart';

class HomScreen extends StatelessWidget {
  const HomScreen({Key? key}) : super(key: key);


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
      body: Column(
        children:  [
          const Center(child: Text("Home Screen")),
          Center(
            child: IconButton(onPressed:() {
              navigateToMyApp(context);
            },
                icon: const Icon(Icons.arrow_back) , color: primaryColor,),
          ),
        ],
      ),
    );
  }
}

