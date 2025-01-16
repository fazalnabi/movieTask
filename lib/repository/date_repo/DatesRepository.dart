import 'package:tentwentytask/models/movie_dates/MovieDateModel.dart';

class DatesRepository {
  List<MovieDateModel> getDateList() {
    DateTime now = DateTime.now();
    DateTime lastDateOfMonth = DateTime(now.year, now.month + 1, 0);

    List<MovieDateModel> dates = List.generate(
      lastDateOfMonth.day - now.day + 1,
      (index) => MovieDateModel(
          date: DateTime(now.year, now.month, now.day + index),
          isSelected: false),
    );
    if (dates.isNotEmpty) {
      dates[0].isSelected = true;
    }
    return dates;
  }
}
