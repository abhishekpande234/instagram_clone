import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/add_post_screen.dart';

import '../screens/feed_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  Center(child: FeedScreen()),
  Center(child: SearchScreen()),
  Center(child: AddPostScreen()),
  Center(child: Text('Favorite')),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
];