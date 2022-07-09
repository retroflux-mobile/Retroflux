import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickerWidget extends StatefulWidget {
  final TextEditingController textController;
  const ImagePickerWidget(this.textController, {Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ImagePickerState extends State<ImagePickerWidget> {
  AppState? state;
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    if (widget.textController.text.isNotEmpty) {
      state = AppState.picked;
      imageFile = XFile(widget.textController.text);
    } else {
      state = AppState.free;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          imageFile != null
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  child: Image.file(
                    File(imageFile!.path),
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              if (state == AppState.free)
                _pickImage();
              else if (state == AppState.picked)
                _cropImage();
              else if (state == AppState.cropped) _clearImage();
            },
            child: _buildButtonIcon(),
          )
        ],
      ),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    imageFile = await _picker.pickImage(source: ImageSource.gallery);
    await _cropImage();
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
        widget.textController.text = imageFile!.path;
      });
    }
  }

  Future<Null> _cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      imageFile = XFile(croppedFile.path);
      setState(() {
        state = AppState.cropped;
        widget.textController.text = imageFile!.path;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
      widget.textController.text = "";
    });
  }
}
