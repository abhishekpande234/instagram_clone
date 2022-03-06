import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost({required String description,
    required Uint8List file,
    required String uid,
    required String username,
    // String profileImage,
    required String postUrl,
  }) async {
    String res = 'Some error occurred';
    try {
      String photoUrl = await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();

      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        // profileImage :  profileImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'Success';
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
