// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'wallpaper_bloc.dart';

abstract class WallpaperEvent extends Equatable {
  const WallpaperEvent();
}

class GetRecentImagesEvent extends WallpaperEvent {
  @override
  List<Object> get props => [];
}

class GetSearchedImagesEvent extends WallpaperEvent {
  final String query;
  const GetSearchedImagesEvent({
    required this.query,
  });
  @override
  List<Object> get props => [query];
}

class GetNextImagesPageEvent extends WallpaperEvent {
  final int pageIndex;
  const GetNextImagesPageEvent({
    required this.pageIndex,
  });
  @override
  List<Object> get props => [pageIndex];
}

class SaveImageToFavoritesEvent extends WallpaperEvent {
  final ImageDataR image;
  const SaveImageToFavoritesEvent({
    required this.image,
  });
  @override
  List<Object> get props => [image];
}

class GetSavedImagesFromDatabaseEvent extends WallpaperEvent {
  @override
  List<Object> get props => [];
}
