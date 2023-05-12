// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../domain/entities/image_l.dart';

class ImageFavoriteViewPage extends StatelessWidget {
  final int heroTag;
  final ImageDataL imageL;

  const ImageFavoriteViewPage({
    Key? key,
    required this.heroTag,
    required this.imageL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 200,
                child: imageL.title == ''
                    ? const Text(
                        "No Title Found",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    : Text(
                        imageL.title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
              ),
              const Icon(
                Icons.favorite,
                color: Colors.black,
                size: 30,
              )
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Hero(
                  tag: heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(imageL.imageUrl),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
