import 'package:clean_inshallah/features/wallpaper/domain/entities/image_l.dart';
import 'package:clean_inshallah/features/wallpaper/domain/entities/image_r.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/images_repository.dart';
import '../datasources/image_remote_data_source.dart';

class ImagesRepositoryImpl extends ImagesRepository {
  final ImageRemoteDataSource remoteDataSource;
  //final ImageLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ImagesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ImageDataR>>> getRecentImages(
      {required int pageIndex}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getRecentImages(pageIndex);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<ImageDataR>>> getSearchData(
      {required String query}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.searchRecentImages(query);

        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveImageDate(
      {required ImageDataR image}) async {
    try {
      final localData = await remoteDataSource.saveImageToDatabase(image);

      return Right(localData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ImageDataL>>> getSavedImages() async {
    try {
      final localData = await remoteDataSource.getSavedImagesFromDatabase();

      return Right(localData);
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }
}
