import 'package:tentwentytask/database/MovieDatabase.dart';
import 'package:tentwentytask/models/movie/Movie.dart';

class DatabaseRepo {
  MovieDatabase database;
  DatabaseRepo(this.database);

  Future<List<Movie>> getAllMovies() {
    return database.movieDao.getMovieList();
  }

  Future<void> addMovies(List<Movie> movieList) async {
    List<Movie> tempList = await getAllMovies();
    if (tempList.isEmpty) {
      for (Movie movie in movieList) {
        await database.movieDao.insertMovies(movie);
      }
    }
  }
}
