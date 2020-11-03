import 'package:blog_app/constants/shared/ui_helpers.dart';
import 'package:blog_app/constants/widgets/input_field.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/ui/editPost/edit_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EditPostView extends StatelessWidget {
  final titleController = TextEditingController();
  final Post edittingPost;

  EditPostView({Key key, this.edittingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditPostViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
            floatingActionButton: FloatingActionButton(
                child: !model.isBusy
                    ? Icon(Icons.add)
                    : CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white)),
                onPressed: null),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  verticalSpace(40),
                  Text(
                    'Create Post',
                    style: TextStyle(fontSize: 26),
                  ),
                  verticalSpaceMedium,
                  InputField(
                    placeholder: 'Title',
                    controller: titleController,
                  ),
                  verticalSpaceMedium,
                  Text('Post Image'),
                  verticalSpaceSmall,
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(
                      'Tap to add post image',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  )
                ],
              ),
            )),
        viewModelBuilder: () => EditPostViewModel(post: edittingPost));
  }
}
