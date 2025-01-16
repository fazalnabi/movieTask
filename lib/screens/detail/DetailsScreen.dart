import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/bloc/details/details_bloc.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/config/Utils.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/network_manager/repository.dart';
import 'package:tentwentytask/widgets/CustomButton.dart';

class DetailsScreen extends StatefulWidget {
  Movie movie;
  DetailsScreen({super.key, required this.movie});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var detailsBloc;

  @override
  void initState() {
    // TODO: implement initState
    detailsBloc = BlocProvider.of<DetailsBloc>(context);
    detailsBloc.add(FetchMovieDetailsEvent(widget.movie.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 1), () {
    //   Navigator.pushNamed(context, RoutesName.videoPlayerScreen);
    // });
    return Scaffold(
      body: BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailsErrorState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is MovieDetailsLoadedState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.52,
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                '${Repository.imageBaseUrl}original/${state.movieDetails.backdropPath}',
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.red, BlendMode.colorBurn)),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ],
                      ),
                    ),
                    PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        centerTitle: false,
                        leadingWidth: 26.sp,

                        automaticallyImplyLeading: true,
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorBackground.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Icon(
                                Platform.isAndroid
                                    ? Icons.arrow_back
                                    : Icons.arrow_back_ios,
                                size: 13.sp,
                              ),
                            ),
                          ),
                        ),
                        iconTheme: const IconThemeData(color: colorWhite),
                        flexibleSpace: Container(),
                        title: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.sp, vertical: 4.sp),
                          decoration: BoxDecoration(
                              color: colorBackground.withOpacity(0.2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            'Watch',
                            style: kHeadingStyle.copyWith(color: colorWhite),
                          ),
                        ),
                        // Any other app bar customization
                      ),
                    ),
                    Positioned(
                      top: 190, // Adjust to control vertical positioning
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            state.movieDetails.title,
                            textAlign: TextAlign.center,
                            style: kHeadingStyle.copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 12.sp,
                          ),
                          Text(
                            'In theaters ${Utils.formatDate(state.movieDetails.releaseDate.toString())}',
                            style: kHeadingStyle.copyWith(color: colorWhite),
                          ),
                          SizedBox(
                            height: 16.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 26.sp),
                            child: CustomButton(
                                isEnabled: true,
                                onClick: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.ticketScreen,
                                      arguments: widget.movie);
                                },
                                child: Text(
                                  'Get Ticket',
                                  style: kButtonTextStyle,
                                )),
                          ),
                          SizedBox(
                            height: 12.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 26.sp),
                            child: CustomButton(
                                btnColor: Colors.transparent,
                                isEnabled: true,
                                onClick: () {
                                  Navigator.pushNamed(
                                      context, RoutesName.videoPlayerScreen,
                                      arguments: state.movieDetails.id);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.play_arrow,
                                      color: colorWhite,
                                    ),
                                    Text(
                                      'Watch Trailer',
                                      style: kButtonTextStyle,
                                    ),
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 16.sp,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.sp),
                  child: Text(
                    'Genre',
                    style: kHeadingStyle,
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                SizedBox(
                  height: 20.sp,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.movieDetails.genres.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          margin: EdgeInsets.only(
                              right: 6.sp, left: index == 0 ? 12.sp : 0),
                          decoration: BoxDecoration(
                              color: Utils().getColor(index),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: IntrinsicWidth(
                            child: Center(
                              child: Text(
                                state.movieDetails.genres[index].name,
                                style: kGenreStyle,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 12.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: Divider(
                    height: 0.1,
                    color: Colors.grey.withOpacity(0.4),
                  ),
                ),
                SizedBox(
                  height: 12.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: Text(
                    'Overview',
                    style: kHeadingStyle,
                  ),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: Text(
                    state.movieDetails.overview,
                    style: kNormalTextStyle.copyWith(),
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
