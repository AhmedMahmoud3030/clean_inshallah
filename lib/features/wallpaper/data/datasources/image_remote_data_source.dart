// ignore_for_file: constant_identifier_names

import 'dart:typed_data';

import 'package:clean_inshallah/features/wallpaper/domain/entities/image_r.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/strings/api_strings.dart';
import '../../domain/entities/image_l.dart';
import '../models/images_l_model.dart';
import '../models/images_r_model.dart';

abstract class ImageRemoteDataSource {
  Future<List<ImageDataR>> getRecentImages(int pageIndex);
  Future<List<ImageDataR>> searchRecentImages(String query);

  Future<Unit> saveImageToDatabase(ImageDataR image);
  Future<List<ImageDataL>> getSavedImagesFromDatabase();
}

class ImageRemoteDataSourceImpl extends ImageRemoteDataSource {
  @override
  Future<List<ImageDataR>> getRecentImages(int pageIndex) async {
    final response = await Dio().get(
        '${ApiConstants.baseUrl}?method=flickr.photos.getRecent&api_key=${ApiConstants.apiKey}&per_page=10&format=json&nojsoncallback=1&page=$pageIndex');
    print(response);
    if (response.statusCode == 200) {
      return List<ImageDataR>.from(
        (response.data["photos"]["photo"] as List).map(
          (e) => ImageDataRModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageDataR>> searchRecentImages(String query) async {
    final response = await Dio().get(ApiConstants.searchImage(query));
    print(response);
    if (response.statusCode == 200) {
      return List<ImageDataR>.from(
        (response.data["photos"]["photo"] as List).map(
          (e) => ImageDataRModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> saveImageToDatabase(ImageDataR image) async {
    Response response = await Dio().get(image.imageUrl,
        options: Options(responseType: ResponseType.bytes));

    if (response.statusCode == 200) {
      Uint8List imageData = response.data;
      Database db = await openDatabase('flicker_app.db');
      await db.execute(
          'CREATE TABLE IF NOT EXISTS images (id INTEGER PRIMARY KEY, data BLOB, title TEXT)');
      await db.insert('images', {'data': imageData, 'title': image.title});
      print('Saved hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
      return unit;
    } else {
      throw ServerException();
    }

// Uint8List imageData = result[0]['data'];
//Image.memory(imageData);
  }

  @override
  Future<List<ImageDataL>> getSavedImagesFromDatabase() async {
    Database db = await openDatabase('flicker_app.db');

    List<Map> result = await db.query('images');
    if (result.isNotEmpty) {
      return List<ImageDataL>.from(
        (result).map(
          (e) => ImageDataLModel.fromSql(e),
        ),
      );
    } else {
      throw EmptyCacheException();
    }
  }
}
