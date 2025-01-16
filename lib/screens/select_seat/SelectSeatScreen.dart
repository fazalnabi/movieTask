import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/config/Images.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/widgets/CustomButton.dart';
import 'package:tentwentytask/widgets/SeatWidget.dart';

class SelectSeatScreen extends StatefulWidget {
  Movie movie;
  SelectSeatScreen({super.key, required this.movie});

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorWhite,
        title: Column(
          children: [
            Text(
              widget.movie.title,
              style: kHeadingStyle,
            ),
            Text(
              'March 5, 2021  I  12:30 hall 1',
              style: kButtonTextStyle.copyWith(color: colorLightBlue),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Center(
                      child: InteractiveViewer(
                        minScale: 1.0, // Minimum zoom scale
                        maxScale: 5.0, // Maximum zoom scale
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 34.sp),
                              child: SvgPicture.asset(
                                icRow,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            SvgPicture.asset(
                              icScreen,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SeatWidget(
                        iconPath: icSeatSelected,
                        text: 'Selected',
                        iconColor: colorBrown,
                      ),
                      SeatWidget(
                          iconPath: icSeatSelected,
                          text: 'Not available',
                          iconColor: colorLightGrey),
                    ],
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SeatWidget(
                          iconPath: icSeatSelected,
                          text: 'VIP (150\$)',
                          iconColor: colorPurple),
                      SeatWidget(
                          iconPath: icSeatSelected,
                          text: 'Regular (50 \$)',
                          iconColor: colorLightBlue),
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Container(
                    width: 80.sp,
                    height: 30.sp,
                    padding: EdgeInsets.symmetric(horizontal: 4.sp),
                    decoration: BoxDecoration(
                      color: colorLightGrey.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '4/ ',
                                  style: kGenreStyle.copyWith(
                                      color: colorGunMetal),
                                  // style: kRubikSmallRegular,
                                ),
                                TextSpan(
                                  text: '3 row',
                                  style: kNormalTextStyle.copyWith(
                                      color: colorGunMetal),
                                  // style: kRubikSmallRegular.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.close,
                            size: 12.sp,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              margin: EdgeInsets.only(bottom: 24.sp, right: 12.sp, left: 12.sp),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 42.sp,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width: 80.sp,
                        padding: EdgeInsets.symmetric(horizontal: 4.sp),
                        decoration: BoxDecoration(
                          color: colorLightGrey.withOpacity(0.3),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Totol Price',
                                style:
                                    kGenreStyle.copyWith(color: colorGunMetal),
                              ),
                              Text(
                                '\$ 50',
                                style: kDateTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.sp,
                      ),
                      Expanded(
                        child: CustomButton(
                            isEnabled: true,
                            onClick: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, RoutesName.homeScreen, (r) => false);
                            },
                            child: Text(
                              'Proceed to pay',
                              style: kButtonTextStyle,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
