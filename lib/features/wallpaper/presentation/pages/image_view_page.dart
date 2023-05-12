// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:clean_inshallah/features/wallpaper/presentation/bloc/wallpaper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/image_r.dart';

class ImageViewPage extends StatelessWidget {
  final int heroTag;
  final ImageDataR imageR;

  const ImageViewPage({
    Key? key,
    required this.heroTag,
    required this.imageR,
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
                child: Text(
                  imageR.title,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () => context
                    .read<WallpaperBloc>()
                    .add(SaveImageToFavoritesEvent(image: imageR)),
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
                    child: Image.network(imageR.imageUrl),
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
