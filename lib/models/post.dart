import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Post{
  final String description;
  final String uid;
  // final String photoUrl;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  // final String profileImage;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    // required this.photoUrl,
    required this.username,
    required this.postId,
    required this.postUrl,
    // required this.profileImage,
    required this.datePublished,
    required this.likes,
  });

  Map<String , dynamic> toJson() => {
    "description" : description,
    "username" : username,
    "uid" : uid,
    "postId" : postId,
    "datePublished" : datePublished,
    "postUrl" : postUrl,
    // "profileImage" : profileImage,
    "likes" : likes,
  };

  static Post fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      description: snapshot['description'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      // profileImage: snapshot['profileImage'],
      likes: snapshot['likes'],
      postUrl: snapshot['postUrl'],
      // photoUrl : snapshot['photoUrl'],
    );
  }
}