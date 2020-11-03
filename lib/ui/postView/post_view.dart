import 'package:blog_app/constants/shared/ui_helpers.dart';
import 'package:blog_app/constants/widgets/post_item.dart';
import 'package:blog_app/ui/postView/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PostViewModel>.reactive(
      onModelReady: (model) => model.listenToPosts(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
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
                title: Text('Home'),
                onTap: () => model.navigationToHome(),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(35),
              Row(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                    child: Image.asset('assets/images/title.png'),
                  ),
                ],
              ),
              Expanded(
                  child: model.posts != null
                      ? ListView.builder(
                          itemCount: model.posts.length,
                          itemBuilder: (context, index) => GestureDetector(
                                onLongPress: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 150,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: Icon(Icons.edit),
                                                title: Text('Edit Post'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  model.editPost(index);
                                                },
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.delete),
                                                title: Text('Delete Post'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  model.deletePost(index);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: PostItem(
                                  post: model.posts[index],
                                ),
                              ))
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor),
                          ),
                        ))
            ],
          ),
        ),
      ),
      viewModelBuilder: () => PostViewModel(),
    );
  }
}
