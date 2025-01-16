import 'package:floor/floor.dart';
import 'package:tentwentytask/models/movie/Movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie')
  Future<List<Movie>> getMovieList();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovies(Movie movie);

  @Query('DELETE FROM Movie')
  Future<void> deleteMovies();
}
