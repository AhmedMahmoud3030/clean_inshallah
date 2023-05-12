import 'package:clean_inshallah/features/wallpaper/presentation/bloc/wallpaper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection.dart' as si;
import '../widgets/my_drawer.dart';
import 'image_favorite_view.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          si.sl<WallpaperBloc>()..add(GetSavedImagesFromDatabaseEvent()),
      child: SafeArea(
        child: Scaffold(
          drawer: const MyDrawer(),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'My',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<WallpaperBloc, WallpaperState>(
                  builder: (context, state) {
                    var images = context.read<WallpaperBloc>().savedList;
                    if (state is WallpaperLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WallpaperLoaded ||
                        state is WallpaperLoadingNextPage) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ImageFavoriteViewPage(
                                    heroTag: images[index].id,
                                    imageL: images[index],
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Hero(
                                    tag: index,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.memory(
                                        height: 100,
                                        fit: BoxFit.fill,
                                        images[index].imageUrl,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  images[index].title == ''
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Colors.purple,
                                                Colors.red,
                                              ],
                                            )),
                                            height: 40,
                                            child: const Text(
                                              "No Title From Api, sorry",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          images[index].title,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is WallpaperError) {
                      return const Center(
                        child: Text(
                          'Error',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
