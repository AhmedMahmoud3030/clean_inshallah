import 'package:clean_inshallah/features/wallpaper/presentation/pages/image_view_page.dart';
import 'package:clean_inshallah/features/wallpaper/presentation/pages/search_page.dart';
import 'package:clean_inshallah/features/wallpaper/presentation/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/wallpaper_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    'Wallpaper',
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
                    'App',
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
            Container(
              height: 70,
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                ),
                child: const Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<WallpaperBloc, WallpaperState>(
                builder: (context, state) {
                  var images = context.read<WallpaperBloc>().list;
                  if (state is WallpaperLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WallpaperLoaded ||
                      state is WallpaperLoadingNextPage) {
                    return GridView.builder(
                      controller:
                          context.read<WallpaperBloc>().scrollController,
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
                                builder: (context) => ImageViewPage(
                                  heroTag: int.parse(images[index].id),
                                  imageR: images[index],
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
                                    child: Image.network(
                                      height: 100,
                                      fit: BoxFit.fill,
                                      images[index].imageUrl,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                images[index].title == ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
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
    );
  }
}
