import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  final ImagePicker _picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image != null
            ? ClipOval(
                child: Image.file(
                  image!,
                  height: 120,
                  width: 120,
                ),
              )
            : GestureDetector(
                onTap: () async {
                  log("pressed image upload");
                  var img = await _picker.pickImage(source: ImageSource.camera);
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  CroppedFile? val = await ImageCropper().cropImage(
                    uiSettings: [
                      AndroidUiSettings(
                        toolbarColor: Colors.white,
                        toolbarTitle: "Image Cropper",
                      )
                    ],
                    sourcePath: img!.path,
                    cropStyle: CropStyle.circle,
                    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
                    maxHeight: 600,
                    maxWidth: 600,
                    compressFormat: ImageCompressFormat.jpg,
                  );
                  final temp = File(val!.path);
                  setState(() {
                    image = temp;
                  });
                  prefs.setString("profileImage", val.path);
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey, blurRadius: 10, spreadRadius: 1)
                    ],
                    shape: BoxShape.circle,
                    color: Colors.grey[100],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.drive_folder_upload_outlined,
                          size: 40,
                        ),
                        Text("upload")
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
