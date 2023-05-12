// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ImageDataL extends Equatable {
  final int id;
  final Uint8List imageUrl;

  final String title;
  const ImageDataL({
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  @override
  List<Object> get props => [id, imageUrl, title];
}
