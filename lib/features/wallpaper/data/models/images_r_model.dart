import 'package:clean_inshallah/core/strings/api_strings.dart';

import '../../domain/entities/image_r.dart';

class ImageDataRModel extends ImageDataR {
  const ImageDataRModel(
      {required super.imageUrl, required super.title, required super.id});

  factory ImageDataRModel.fromJson(Map<String, dynamic> json) =>
      ImageDataRModel(
        id: json['id'],
        imageUrl: ApiConstants.imageUrl(
          json['secret'],
          json['server'],
          json['id'],
        ),
        title: json['title'],
      );
}
