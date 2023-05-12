part of 'wallpaper_bloc.dart';

abstract class WallpaperState extends Equatable {
  const WallpaperState();

  @override
  List<Object> get props => [];
}

class WallpaperInitial extends WallpaperState {}

class WallpaperLoading extends WallpaperState {}

class WallpaperLoadingNextPage extends WallpaperState {}

class WallpaperSaved extends WallpaperState {}

class WallpaperLoaded extends WallpaperState {}

class WallpaperError extends WallpaperState {}
