// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_inshallah/features/wallpaper/domain/entities/image_r.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/images_repository.dart';

class GetRecentNextPageImagesUseCase
    extends BaseUseCase<List<ImageDataR>, RecentImagesParameters> {
  final ImagesRepository repository;
  GetRecentNextPageImagesUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ImageDataR>>> call(
      RecentImagesParameters parameters) async {
    return await repository.getRecentImages(pageIndex: parameters.pageIndex);
  }
}

class RecentImagesParameters extends Equatable {
  final int pageIndex;

  const RecentImagesParameters({required this.pageIndex});

  @override
  List<Object?> get props => [pageIndex];
}
