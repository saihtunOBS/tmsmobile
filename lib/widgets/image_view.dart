
import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'cache_image.dart';

void showDialogImage(BuildContext context, dynamic imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: kGreyColor.withValues(alpha: 0.4),),
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: imageUrl is File
                      ? InteractiveViewer(
                          maxScale: 5.0,
                          minScale: 0.01,
                          child: Image.file(imageUrl))
                      : InteractiveViewer(
                          maxScale: 5.0,
                          minScale: 0.01,
                          child: cacheImage(imageUrl)),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: kRedColor,
                        )))
              ],
            ),
          ),
        );
      },
    );
  }