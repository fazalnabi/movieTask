import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/bloc/watch/watch_bloc.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/widgets/MovieWidget.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({super.key});

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  var watchBloc;

  @override
  void initState() {
    // TODO: implement initState
    watchBloc = BlocProvider.of<WatchBloc>(context);
    watchBloc.add(FetchMovieEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScaffold,
        centerTitle: false,
        title: Text(
          'Watch',
          style: kHeadingStyle,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.searchScreen);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp),
              child: Icon(
                Icons.search,
                color: colorGunMetal,
                size: 20.sp,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<WatchBloc, WatchState>(builder: (context, state) {
        if (state is MovieLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieLoadedState) {
          return Padding(
            padding: EdgeInsets.only(left: 12.sp, right: 12.sp, top: 10.sp),
            child: ListView.builder(
                itemCount: state.moviesList.length,
                itemBuilder: (context, index) {
                  return MovieWidget(
                    movie: state.moviesList[index],
                    onClick: () {
                      Navigator.pushNamed(context, RoutesName.detailsScreen,
                          arguments: state.moviesList[index]);
                    },
                  );
                }),
          );
        } else if (state is MovieLoadedFailureState) {
          return Container(
            child: Center(
              child: Text(state.failureMessage),
            ),
          );
        }
        return Container();
      }),
    );
  }
}
