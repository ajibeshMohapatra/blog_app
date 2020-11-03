import 'package:flutter/material.dart';
import 'package:blog_app/ui/home/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(model.title),
        ),
        body: Center(
          child: Text(model.user.fullName),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(model.user.fullName),
                accountEmail: Text(model.user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    model.user.fullName[0],
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                title: Text(model.title),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text("Create Post"),
                onTap: () => model.navigationToCreatePost(),
              ),
              ListTile(
                title: Text("Posts"),
                onTap: () => model.navigationToPosts(),
              ),
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: () => model.signOut()),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
