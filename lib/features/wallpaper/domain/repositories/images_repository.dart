import 'package:clean_inshallah/features/wallpaper/domain/entities/image_r.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/image_l.dart';

abstract class ImagesRepository {
  Future<Either<Failure, List<ImageDataR>>> getRecentImages(
      {required int pageIndex});
  Future<Either<Failure, List<ImageDataR>>> getSearchData(
      {required String query});
  Future<Either<Failure, Unit>> saveImageDate({required ImageDataR image});
  Future<Either<Failure, List<ImageDataL>>> getSavedImages();
}
