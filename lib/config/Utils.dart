import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:tentwentytask/config/AppColors.dart';

class Utils {
  List<Color> colorList = [
    colorLightGreen,
    colorLightPink,
    colorPurple,
    colorBrown
  ];
  static String formatDate(String inputDate) {
    DateTime dateTime =
        DateTime.parse(inputDate); // Convert the string to DateTime
    String formattedDate = DateFormat('MMMM d, y')
        .format(dateTime)
        .toLowerCase(); // Format the date
    return formattedDate;
  }

  Color getColor(int index) {
    try {
      return colorList[index];
    } catch (e) {
      return colorList[0];
    }
  }
}
