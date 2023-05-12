import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/image_l.dart';
import '../repositories/images_repository.dart';

class GetSavedImagesUseCase
    extends BaseUseCase<List<ImageDataL>, NoParameters> {
  final ImagesRepository repository;

  GetSavedImagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ImageDataL>>> call(
      NoParameters noParameters) async {
    return await repository.getSavedImages();
  }
}
