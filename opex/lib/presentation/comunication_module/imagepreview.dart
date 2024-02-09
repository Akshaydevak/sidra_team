import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyMedia extends StatefulWidget {
  final XFile? imageview;

  MyMedia({Key? key, required this.imageview}) : super(key: key);

  @override
  State<MyMedia> createState() => _MyMediaState();
}

class _MyMediaState extends State<MyMedia> {
  late File _imageFile;
  late int _fileSizeInBytes;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (widget.imageview != null) {
      _imageFile = File(widget.imageview!.path);
      _fileSizeInBytes = await _imageFile.length();
    }
    setState(() {});
  }

  String _getSizeString(int bytes) {
    const int KB_IN_BYTES = 1024;
    const int MB_IN_BYTES = 1024 * 1024;

    if (bytes >= MB_IN_BYTES) {
      double sizeInMB = bytes / MB_IN_BYTES;
      return '${sizeInMB.toStringAsFixed(2)} MB';
    } else if (bytes >= KB_IN_BYTES) {
      double sizeInKB = bytes / KB_IN_BYTES;
      return '${sizeInKB.toStringAsFixed(2)} KB';
    } else {
      return '$bytes bytes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Details'),
      ),
      body: _imageFile != null
          ? Container(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.file(_imageFile),
                    SizedBox(height: 20),
                    Text(
                      'File Size: ${_getSizeString(_fileSizeInBytes)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
            ),
          )
          : Center(
              child: Text('No image selected.'),
            ),
    );
  }
}
