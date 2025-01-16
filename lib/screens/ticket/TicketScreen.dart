import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/bloc/ticket/ticket_bloc.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/config/Images.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/config/Utils.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/widgets/CustomButton.dart';

class TicketScreen extends StatefulWidget {
  Movie movie;
  TicketScreen({super.key, required this.movie});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  var ticketBloc;
  @override
  initState() {
    ticketBloc = BlocProvider.of<TicketBloc>(context);
    ticketBloc.add(MovieDateEvent());
    super.initState();
  }

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
              'In theaters ${Utils.formatDate(widget.movie.releaseDate.toString())}',
              style: kButtonTextStyle.copyWith(color: colorLightBlue),
            ),
          ],
        ),
      ),
      body: BlocBuilder<TicketBloc, TicketState>(builder: (context, state) {
        if (state is MovieDateState) {
          print('date list ${state.list.length}');
          return CustomScrollView(
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
                      Text(
                        'Date',
                        style: kHeadingStyle,
                      ),
                      SizedBox(
                        height: 12.sp,
                      ),
                      SizedBox(
                        height: 24.sp,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            String formattedDate = DateFormat('d MMM')
                                .format(state.list[index].date);
                            return Container(
                              margin:
                                  EdgeInsets.only(left: index == 0 ? 0 : 10.sp),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: state.list[index].isSelected
                                    ? colorLightBlue
                                    : colorLightGrey.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Center(
                                child: Text(
                                  formattedDate,
                                  style: kDateTextStyle.copyWith(
                                      color: state.list[index].isSelected
                                          ? colorWhite
                                          : colorYankeesBlue),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40.sp,
                      ),
                      SizedBox(
                        height: 190.sp,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  EdgeInsets.only(left: index == 0 ? 0 : 10.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '12:30 ',
                                          style: kGenreStyle.copyWith(
                                              color: colorGunMetal),
                                          // style: kRubikSmallRegular,
                                        ),
                                        TextSpan(
                                          text: 'Cinetech + hall 1',
                                          style: kNormalTextStyle,
                                          // style: kRubikSmallRegular.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    height: 130.sp,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: index == 0 ? 2 : 0.4,
                                          color: index == 0
                                              ? colorLightBlue
                                              : colorLightGrey),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(16),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SvgPicture.asset(
                                        icScreen,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'From ',
                                          style: kNormalTextStyle,
                                          // style: kRubikSmallRegular,
                                        ),
                                        TextSpan(
                                          text: '50\$',
                                          style: kGenreStyle.copyWith(
                                              color: colorGunMetal),
                                          // style: kRubikSmallRegular.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                        TextSpan(
                                          text: ' or ',
                                          style: kNormalTextStyle,
                                          // style: kRubikSmallRegular,
                                        ),
                                        TextSpan(
                                          text: '2500 bonus',
                                          style: kGenreStyle.copyWith(
                                              color: colorGunMetal),
                                          // style: kRubikSmallRegular.copyWith(fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: 24.sp, right: 24.sp, left: 24.sp),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                        isEnabled: true,
                        onClick: () {
                          Navigator.pushNamed(
                              context, RoutesName.selectSeatScreen,
                              arguments: widget.movie);
                        },
                        child: Text(
                          'Select Seats',
                          style: kButtonTextStyle,
                        )),
                  ),
                ),
              )
            ],
          );
        }
        return Container();
      }),
    );
  }
}
