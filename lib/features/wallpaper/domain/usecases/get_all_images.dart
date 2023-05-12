import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/image_r.dart';
import '../repositories/images_repository.dart';

class GetRecentImagesUseCase
    extends BaseUseCase<List<ImageDataR>, NoParameters> {
  final ImagesRepository repository;

  GetRecentImagesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<ImageDataR>>> call(
      NoParameters noParameters) async {
    return await repository.getRecentImages(pageIndex: 1);
  }
}
