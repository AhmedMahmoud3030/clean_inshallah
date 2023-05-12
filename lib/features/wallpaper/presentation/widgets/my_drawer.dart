import 'package:clean_inshallah/features/wallpaper/presentation/pages/favorite_page.dart';
import 'package:clean_inshallah/features/wallpaper/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              image: DecorationImage(
                image: NetworkImage(
                  "https://img.freepik.com/free-photo/abstract-colorful-splash-3d-background-generative-ai-background_60438-2503.jpg?w=1380&t=st=1683888254~exp=1683888854~hmac=f0e6387d72af8cf67649ea8ad2cd8e8601cfbe2b4eab5edbded3a25a6971bd81",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 8.0,
                  left: 4.0,
                  child: Text(
                    "Flicker App",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const FavoritePage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
