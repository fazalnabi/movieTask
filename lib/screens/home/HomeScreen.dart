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
    const Dashboard(),
    const WatchScreen(),
    const Scaffold(),
    const Scaffold()
  ];
  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: bottomBar(homeBloc),
          body: screenList[homeBloc.currentIndex],
        );
      },
    );
  }

  Widget bottomBar(HomeBloc homeBloc) {
    return Container(
      height: 77.sp,
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
                icon: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 4),
                  child: SvgPicture.asset(
                    icDashboard,
                    colorFilter: ColorFilter.mode(
                        homeBloc.currentIndex == 0
                            ? Colors.white
                            : colorBottomBarItem,
                        BlendMode.srcIn),
                  ),
                ),
                label: 'Dashboard'),
            BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 4),
                  child: SvgPicture.asset(icWatch,
                      colorFilter: ColorFilter.mode(
                          homeBloc.currentIndex == 1
                              ? Colors.white
                              : colorBottomBarItem,
                          BlendMode.srcIn)),
                ),
                label: 'Watch'),
            BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 4),
                  child: SvgPicture.asset(icMediaLibrary,
                      colorFilter: ColorFilter.mode(
                          homeBloc.currentIndex == 2
                              ? Colors.white
                              : colorBottomBarItem,
                          BlendMode.srcIn)),
                ),
                label: 'Media Library'),
            BottomNavigationBarItem(
                icon: Container(
                    margin: EdgeInsets.only(top: 10), child: Icon(Icons.menu)),
                label: 'More'),
          ],
        ),
      ),
    );
  }
}
