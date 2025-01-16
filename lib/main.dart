import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/BlocProviders.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/config/routes.dart';
import 'package:tentwentytask/database/MovieDatabase.dart';
import 'package:tentwentytask/repository/database_repo/DatabaseRepo.dart';
import 'package:tentwentytask/screens/home/HomeScreen.dart';

final getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

Future<void> setupLocator() async {
  final database =
      await $FloorMovieDatabase.databaseBuilder('movieDatabase.db').build();
  getIt.registerSingleton<MovieDatabase>(database);

  getIt.registerSingleton<DatabaseRepo>(DatabaseRepo(database));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: BlocProviders.getBlocs(),
        child: MaterialApp(
          title: 'Movies',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: colorLightBlue),
            scaffoldBackgroundColor: colorBackground,
            useMaterial3: true,
          ),
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: RoutesName.homeScreen,
        ),
      );
    });
  }
}
