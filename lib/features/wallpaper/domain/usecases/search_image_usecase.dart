// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_inshallah/features/wallpaper/domain/entities/image_r.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/images_repository.dart';

class SearchImagesUseCase
    extends BaseUseCase<List<ImageDataR>, SearchImageParameters> {
  final ImagesRepository repository;

  SearchImagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ImageDataR>>> call(
      SearchImageParameters parameters) async {
    return await repository.getSearchData(query: parameters.query);
  }
}

class SearchImageParameters extends Equatable {
  final String query;

  const SearchImageParameters({required this.query});

  @override
  List<Object?> get props => [query];
}
