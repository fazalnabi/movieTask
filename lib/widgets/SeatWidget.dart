import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/config/AppStyles.dart';

class SeatWidget extends StatelessWidget {
  String iconPath;
  Color iconColor;
  String text;
  SeatWidget(
      {super.key,
      required this.iconPath,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          SizedBox(
            width: 4.sp,
          ),
          Text(
            text,
            style: kNormalTextStyle,
          )
        ],
      ),
    );
  }
}
