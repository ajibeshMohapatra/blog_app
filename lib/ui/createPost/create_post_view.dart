import 'package:blog_app/constants/shared/ui_helpers.dart';
import 'package:blog_app/constants/widgets/input_field.dart';
import 'package:blog_app/ui/createPost/create_post_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  CreatePostView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreatePostViewModel>.reactive(
      viewModelBuilder: () => CreatePostViewModel(),
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.isBusy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.isBusy) {
                model.addPost(title: titleController.text);
              }
            },
            backgroundColor: !model.isBusy
                ? Theme.of(context).primaryColor
                : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                verticalSpaceSmall,
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 80.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    model.selectImage('c');
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt,
                                          size: 48.0, semanticLabel: 'Camera'),
                                      Text('Camera'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    model.selectImage('g');
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_photo_alternate_rounded,
                                          size: 48.0, semanticLabel: 'Gallery'),
                                      Text('Gallery'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: model.selectedImage == null
                        ? Text(
                            'Tap to add post image',
                            style: TextStyle(color: Colors.grey[400]),
                          )
                        : Image.file(model.selectedImage),
                  ),
                ),
                verticalSpaceMedium,
                model.uploadTask == null
                    ? RaisedButton(
                        onPressed: () =>
                            model.upload(title: titleController.text),
                        child: Text('Upload'),
                      )
                    : model.uploadTask.isComplete
                        ? Text('Image uoloaded successfully')
                        : StreamBuilder<StorageTaskEvent>(
                            stream: model.uploadTask.events,
                            builder: (context, snapshot) {
                              var event = snapshot?.data?.snapshot;
                              double progressPercent = event != null
                                  ? event.bytesTransferred /
                                      event.totalByteCount
                                  : 0;
                              return Column(
                                children: [
                                  LinearProgressIndicator(
                                    value: progressPercent,
                                  ),
                                  Text('${(progressPercent * 100)} %'),
                                ],
                              );
                            })
              ],
            ),
          )),
    );
  }
}
