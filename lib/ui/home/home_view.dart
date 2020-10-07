import 'package:flutter/material.dart';
import 'package:blog_app/ui/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text(model.title),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () => model.navigationToLogin()),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
