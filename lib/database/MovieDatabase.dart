import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:tentwentytask/database/MovieDao.dart';
import 'package:tentwentytask/models/movie/Movie.dart';

part 'MovieDatabase.g.dart';

@Database(version: 2, entities: [Movie])
abstract class MovieDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
