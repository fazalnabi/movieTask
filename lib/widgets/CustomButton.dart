import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final bool isEnabled;
  final Function onClick;
  final Color btnColor;
  final Color? btnTextColor;

  const CustomButton(
      {super.key,
      required this.child,
      required this.isEnabled,
      required this.onClick,
      this.btnColor = colorLightBlue,
      this.btnTextColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 39.sp,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return btnColor;
              } else if (states.contains(WidgetState.disabled)) {
                return colorBottomBarItem;
              }
              return btnColor; // Use the component's default.
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(
                    color: btnColor == Colors.transparent
                        ? colorLightBlue
                        : Colors.transparent)),
          ),
        ),
        onPressed: isEnabled == true
            ? () {
                onClick();
              }
            : null,
        child: child,
      ),
    );
  }
}
