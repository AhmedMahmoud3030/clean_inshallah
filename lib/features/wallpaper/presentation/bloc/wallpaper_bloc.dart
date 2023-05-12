// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:clean_inshallah/features/wallpaper/domain/entities/image_r.dart';
import 'package:clean_inshallah/features/wallpaper/domain/usecases/get_all_images.dart';
import 'package:clean_inshallah/features/wallpaper/domain/usecases/get_images_from_database.dart';
import 'package:clean_inshallah/features/wallpaper/domain/usecases/save_image_to_database_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../domain/entities/image_l.dart';
import '../../domain/usecases/get_next_page_images.dart';
import '../../domain/usecases/search_image_usecase.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  final GetRecentImagesUseCase getRecentImagesUseCase;
  final GetRecentNextPageImagesUseCase getRecentNextPageImagesUseCase;
  final SearchImagesUseCase searchImagesUseCase;

  final SaveImageToDataBaseUseCase saveImageToDataBaseUseCase;
  final GetSavedImagesUseCase getSavedImagesUseCase;

  int page = 1;
  bool isSaved = false;
  List<ImageDataR> list = [];
  List<ImageDataR> searchList = [];
  List<ImageDataL> savedList = [];

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  WallpaperBloc({
    required this.getSavedImagesUseCase,
    required this.getRecentImagesUseCase,
    required this.getRecentNextPageImagesUseCase,
    required this.searchImagesUseCase,
    required this.saveImageToDataBaseUseCase,
  }) : super(WallpaperInitial()) {
    scrollController.addListener(() {
      add(GetNextImagesPageEvent(pageIndex: page));
    });
    //?remote
    on<GetRecentImagesEvent>(_getRecentImagesEvent);
    on<GetSearchedImagesEvent>(_getSearchedImagesEvent);
    on<GetNextImagesPageEvent>(_getNextImagesPageEvent);

    //?local
    on<SaveImageToFavoritesEvent>(_saveImageToFavoritesEvent);
    on<GetSavedImagesFromDatabaseEvent>(_getSavedImagesFromDatabaseEvent);
  }

  FutureOr<void> _getRecentImagesEvent(
      GetRecentImagesEvent event, Emitter<WallpaperState> emit) async {
    emit(WallpaperLoading());
    final result = await getRecentImagesUseCase(const NoParameters());
    result.fold(
      (l) {
        emit(WallpaperError());
      },
      (r) {
        list = r;
        emit(WallpaperLoaded());
      },
    );
  }

  FutureOr<void> _getSearchedImagesEvent(
      GetSearchedImagesEvent event, Emitter<WallpaperState> emit) async {
    emit(WallpaperLoading());
    final result =
        await searchImagesUseCase(SearchImageParameters(query: event.query));
    result.fold(
      (l) {
        emit(WallpaperError());
      },
      (r) {
        searchList = r;
        emit(WallpaperLoaded());
      },
    );
  }

  FutureOr<void> _getNextImagesPageEvent(
      GetNextImagesPageEvent event, Emitter<WallpaperState> emit) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadingMore = true;
      page++;
      emit(WallpaperLoadingNextPage());

      final result = await getRecentNextPageImagesUseCase(
          RecentImagesParameters(pageIndex: event.pageIndex));
      result.fold(
        (l) {
          emit(WallpaperError());
        },
        (r) {
          list.addAll(r);
          emit(WallpaperLoaded());
        },
      );
    }
  }

  FutureOr<void> _saveImageToFavoritesEvent(
      SaveImageToFavoritesEvent event, Emitter<WallpaperState> emit) async {
    emit(WallpaperLoading());
    final result = await saveImageToDataBaseUseCase(
        SaveImageDataParameters(image: event.image));
    result.fold(
      (l) {
        emit(WallpaperError());
      },
      (r) {
        isSaved = true;
        emit(WallpaperSaved());
      },
    );
  }

  FutureOr<void> _getSavedImagesFromDatabaseEvent(
      GetSavedImagesFromDatabaseEvent event,
      Emitter<WallpaperState> emit) async {
    emit(WallpaperLoading());
    final result = await getSavedImagesUseCase(const NoParameters());
    result.fold(
      (l) {
        emit(WallpaperError());
      },
      (r) {
        savedList = r;
        emit(WallpaperLoaded());
      },
    );
  }
}
