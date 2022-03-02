import 'dart:io';

import 'package:anggota/service/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadEmpty extends StatelessWidget {
  final VoidCallback onTapModal;
  const UploadEmpty({Key? key, required this.onTapModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      height: 56.0,
      width: 56.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(4.0)),
      child: IconButton(
          icon: const Icon(Icons.add, color: Colors.grey),
          onPressed: onTapModal),
    );
  }
}

typedef UploadEmptyCallback = void Function(BuildContext context);
typedef UploadImageCallback = void Function();

class UploadImage extends StatelessWidget {
  final String? fileString;
  final File? filePath;
  final bool edited;
  final UploadImageCallback onTapClose;
  const UploadImage(
      {Key? key,
      this.filePath,
      this.fileString,
      required this.edited,
      required this.onTapClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 145.0,
      width: 130.0,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
                padding: const EdgeInsets.all(2.0),
                height: 125.0,
                width: 125.0,
                child: (fileString != '')
                    ? CachedNetworkImage(
                        imageUrl: fileString.toString(),
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                              width: 125,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: kPrimaryColor, width: 2.0),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(70.0)),
                                image: DecorationImage(image: imageProvider),
                              ),
                            ),
                        errorWidget: (context, url, error) => Image.asset(
                              'assets/icons/ic-bgactivity.png',
                              height: 156.0,
                            ))
                    : Image.file(
                        filePath!,
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.center,
                      )),
          ),
          (edited)
              ? Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: onTapClose,
                    child: const Icon(
                      CupertinoIcons.clear_circled_solid,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
