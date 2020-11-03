import 'package:blog_app/ui/home/home_view.dart';
import 'package:blog_app/ui/loading.dart';
import 'package:blog_app/ui/login/login_view.dart';
import 'package:blog_app/ui/startup/srartup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      builder: (context, model, child) {
        var x = model.data;
        return model.isBusy ? Loading() : (x ? HomeView() : LoginView());
      },
    );
  }
}
