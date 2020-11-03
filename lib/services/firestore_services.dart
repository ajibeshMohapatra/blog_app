import 'dart:async';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final _usercollectionReference =
      FirebaseFirestore.instance.collection('users');
  final _postcollectionReference =
      FirebaseFirestore.instance.collection('posts');

  final StreamController<List<Post>> _postController =
      StreamController<List<Post>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usercollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usercollectionReference.doc(uid).get();
      return User.fromData(userData.data());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addPost(Post post) async {
    try {
      await _postcollectionReference.add(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getPosts() async {
    try {
      var postDocumentSnapshot = await _postcollectionReference.get();
      if (postDocumentSnapshot.docs.isNotEmpty) {
        return postDocumentSnapshot.docs
            .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
            .where((element) => element.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    _postcollectionReference.snapshots().listen((postSnapshot) {
      if (postSnapshot.docs.isNotEmpty) {
        var posts = postSnapshot.docs
            .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
            .where((element) => element.title != null)
            .toList();
        _postController.add(posts);
      }
    });
    return _postController.stream;
  }

  Future deletePost(String documentId) async {
    await _postcollectionReference.doc(documentId).delete();
  }

  Future updatePosts(Post post) async {
    try {
      await _postcollectionReference.doc(post.documentId).update(post.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
