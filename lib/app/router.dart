import 'package:auto_route/auto_route_annotations.dart';
import 'package:blog_app/ui/createPost/create_post_view.dart';
import 'package:blog_app/ui/editPost/edit_post_view.dart';
import 'package:blog_app/ui/home/home_view.dart';
import 'package:blog_app/ui/login/login_view.dart';
import 'package:blog_app/ui/postView/post_view.dart';
import 'package:blog_app/ui/signup/signup_view.dart';
import 'package:blog_app/ui/startup/startup_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: CreatePostView),
    MaterialRoute(page: PostView),
    MaterialRoute(page: EditPostView)
  ],
)
class $Router {}
