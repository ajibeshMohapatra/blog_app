import 'package:auto_route/auto_route_annotations.dart';
import 'package:blog_app/ui/home/home_view.dart';
import 'package:blog_app/ui/login/login_view.dart';
import 'package:blog_app/ui/signup/signup_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: SignUpView)
  ],
)
class $Router {}
