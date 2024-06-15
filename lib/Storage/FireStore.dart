import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FireStore extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FireStoreState();
}

class FireStoreState extends State {
  PlatformFile? pickedfile;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = null;
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'jpeg', 'mp4'],
    );

    if (result == null) return;
    setState(() {
      pickedfile = result.files.first;
      if (pickedfile!.extension == 'mp4') {
        _controller?.dispose();
        _controller = VideoPlayerController.file(File(pickedfile!.path!))
          ..initialize().then((_) {
            setState(() {});
          });
        _controller!.addListener(() {
          setState(() {});
        });
      }
    });
  }

  Future uploadFile() async {
    if (pickedfile == null) return;

    final path = 'Files/${pickedfile!.name}';
    final file = File(pickedfile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Firebase Storage', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (pickedfile != null &&
                (pickedfile!.extension == 'jpg' || pickedfile!.extension == 'jpeg'))
              Expanded(
                child: Container(
                  child: Image.file(
                    File(pickedfile!.path!),
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 4,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            if (pickedfile != null && pickedfile!.extension == 'mp4')
              Expanded(
                child: Center(
                  child: _controller != null
                      ? VideoPlayer(_controller!)
                      : Text('No video selected'),
                ),
              ),

            ElevatedButton(
              onPressed: selectFile,
              child: Text('Select File', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: uploadFile,
              child: Text('Upload File', style: TextStyle(color: Colors.white)),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
