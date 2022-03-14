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
        postUrl: photoUrl,
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

  Future<void> likePost(String postId, String uid, List likes) async {
    try{
      if(likes.contains(uid)){
       await _firestore.collection('posts').doc(postId).update({
          'likes' : FieldValue.arrayRemove([uid]),
        });
      }else{
        await _firestore.collection("posts").doc(postId).update({
          'likes' :  FieldValue.arrayUnion([uid]),
        });
      }
    }catch(e){
      print(e.toString());
    }
  }

  //DELETING POST

  Future<void> deletePost(String postId) async{
    try{
        _firestore.collection('posts').doc(postId).delete();
    }catch(err){
        print(err.toString());
    }
  }

  Future<void> followUser(
        String uid,
        String followId
      ) async{
      try{
           DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
           List following = (snap.data()! as dynamic)['following'];

           if(following.contains(followId)){
             await _firestore.collection('users').doc(followId).update({
                'followers' : FieldValue.arrayRemove([uid])
             });
             await _firestore.collection('users').doc(uid).update({
               'following' : FieldValue.arrayRemove([followId])
             });
           }else{
             await _firestore.collection('users').doc(followId).update({
               'followers' : FieldValue.arrayUnion([uid])
             });
             await _firestore.collection('users').doc(uid).update({
               'following' : FieldValue.arrayUnion([followId])
             });
           }
  }catch(e){
      print(e.toString());
  }
  }

 }
