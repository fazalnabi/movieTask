import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/bloc/home/home_bloc.dart';
import 'package:tentwentytask/bloc/watch/watch_bloc.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/config/Images.dart';
import 'package:tentwentytask/screens/dashboard/Dashboard.dart';
import 'package:tentwentytask/screens/watch/WatchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screenList = [
    Dashboard(),
    WatchScreen(),
    Scaffold(),
    Scaffold()
  ];
  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: SizedBox(
            height: 75.sp,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: BottomNavigationBar(
                backgroundColor: colorGunMetal,
                selectedItemColor: Colors.white,
                selectedLabelStyle: kBottomBarItemStyle,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: colorBottomBarItem,
                currentIndex: homeBloc.currentIndex,
                onTap: (index) {
                  homeBloc.add(BottomBarTapEvent(index));
                },
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        icDashboard,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                            homeBloc.currentIndex == 0
                                ? Colors.white
                                : colorBottomBarItem,
                            BlendMode.srcIn),
                      ),
                      label: 'Dashboard'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(icWatch,
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                              homeBloc.currentIndex == 1
                                  ? Colors.white
                                  : colorBottomBarItem,
                              BlendMode.srcIn)),
                      label: 'Watch'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(icMediaLibrary,
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                              homeBloc.currentIndex == 2
                                  ? Colors.white
                                  : colorBottomBarItem,
                              BlendMode.srcIn)),
                      label: 'Media Library'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(icMore,
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                              homeBloc.currentIndex == 3
                                  ? Colors.white
                                  : colorBottomBarItem,
                              BlendMode.srcIn)),
                      label: 'More'),
                ],
              ),
            ),
          ),
          body: screenList[homeBloc.currentIndex],
        );
      },
    );
  }
}
