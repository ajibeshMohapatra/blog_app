// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../ui/createPost/create_post_view.dart';
import '../ui/editPost/edit_post_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';
import '../ui/postView/post_view.dart';
import '../ui/signup/signup_view.dart';
import '../ui/startup/startup_view.dart';

class Routes {
  static const String homeView = '/home-view';
  static const String loginView = '/login-view';
  static const String signUpView = '/sign-up-view';
  static const String startUpView = '/';
  static const String createPostView = '/create-post-view';
  static const String postView = '/post-view';
  static const String editPostView = '/edit-post-view';
  static const all = <String>{
    homeView,
    loginView,
    signUpView,
    startUpView,
    createPostView,
    postView,
    editPostView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.signUpView, page: SignUpView),
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.createPostView, page: CreatePostView),
    RouteDef(Routes.postView, page: PostView),
    RouteDef(Routes.editPostView, page: EditPostView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(),
        settings: data,
      );
    },
    SignUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpView(),
        settings: data,
      );
    },
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartUpView(),
        settings: data,
      );
    },
    CreatePostView: (data) {
      final args = data.getArgs<CreatePostViewArguments>(
        orElse: () => CreatePostViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreatePostView(key: args.key),
        settings: data,
      );
    },
    PostView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PostView(),
        settings: data,
      );
    },
    EditPostView: (data) {
      final args = data.getArgs<EditPostViewArguments>(
        orElse: () => EditPostViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditPostView(
          key: args.key,
          edittingPost: args.edittingPost,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// CreatePostView arguments holder class
class CreatePostViewArguments {
  final Key key;
  CreatePostViewArguments({this.key});
}

/// EditPostView arguments holder class
class EditPostViewArguments {
  final Key key;
  final Post edittingPost;
  EditPostViewArguments({this.key, this.edittingPost});
}
