// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ImageDataR extends Equatable {
  final String id;
  final String imageUrl;

  final String title;
  const ImageDataR({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  @override
  List<Object> get props => [id, imageUrl, title];
}
