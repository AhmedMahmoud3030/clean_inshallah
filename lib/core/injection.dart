import 'package:clean_inshallah/features/wallpaper/domain/usecases/get_images_from_database.dart';
import 'package:clean_inshallah/features/wallpaper/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../features/wallpaper/data/datasources/image_remote_data_source.dart';
import '../features/wallpaper/data/repositories/images_repository_impl.dart';
import '../features/wallpaper/domain/repositories/images_repository.dart';
import '../features/wallpaper/domain/usecases/get_all_images.dart';
import '../features/wallpaper/domain/usecases/get_next_page_images.dart';
import '../features/wallpaper/domain/usecases/save_image_to_database_usecase.dart';
import '../features/wallpaper/domain/usecases/search_image_usecase.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
//?bloc
  sl.registerFactory(() => WallpaperBloc(
        getSavedImagesUseCase: sl(),
        saveImageToDataBaseUseCase: sl(),
        getRecentImagesUseCase: sl(),
        getRecentNextPageImagesUseCase: sl(),
        searchImagesUseCase: sl(),
      ));

//?usecases
  //?remote
  sl.registerLazySingleton(() => GetRecentImagesUseCase(repository: sl()));
  sl.registerLazySingleton(
      () => GetRecentNextPageImagesUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchImagesUseCase(repository: sl()));
  //?local
  sl.registerLazySingleton(() => SaveImageToDataBaseUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetSavedImagesUseCase(repository: sl()));

//?repository
  sl.registerLazySingleton<ImagesRepository>(
    () => ImagesRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      // localDataSource: sl(),
    ),
  );
//?datasources

  sl.registerLazySingleton<ImageRemoteDataSource>(
      () => ImageRemoteDataSourceImpl());
  // sl.registerLazySingleton<PostLocalDataSource>(
  //     () => PostLocalDataSourceImpl(sharedPreferences: sl()));

//!core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//!external
  // final SharedPreferences sharedPreferences =
  //     await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
