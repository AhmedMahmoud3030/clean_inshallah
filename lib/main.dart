import 'package:clean_inshallah/features/wallpaper/presentation/bloc/bloc.dart';
import 'package:clean_inshallah/features/wallpaper/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import "core/injection.dart" as si;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await si.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => si.sl<WallpaperBloc>()..add(GetRecentImagesEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}
