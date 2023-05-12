// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_inshallah/features/wallpaper/domain/entities/image_r.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/images_repository.dart';

class SaveImageToDataBaseUseCase
    extends BaseUseCase<Unit, SaveImageDataParameters> {
  final ImagesRepository repository;
  SaveImageToDataBaseUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Unit>> call(SaveImageDataParameters parameters) async {
    return await repository.saveImageDate(image: parameters.image);
  }
}

class SaveImageDataParameters extends Equatable {
  final ImageDataR image;

  const SaveImageDataParameters({required this.image});

  @override
  List<Object?> get props => [image];
}
