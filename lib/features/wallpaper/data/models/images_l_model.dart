import 'package:clean_inshallah/features/wallpaper/domain/entities/image_l.dart';

class ImageDataLModel extends ImageDataL {
  const ImageDataLModel(
      {required super.imageUrl, required super.title, required super.id});

  factory ImageDataLModel.fromSql(Map<dynamic, dynamic> sql) => ImageDataLModel(
        id: sql['id'],
        imageUrl: sql['data'],
        title: sql['title'],
      );
}
