import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/config/RoutesName.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/network_manager/repository.dart';

class MovieWidget extends StatelessWidget {
  Movie movie;
  Function onClick;
  bool isGrid;
  MovieWidget(
      {super.key,
      required this.movie,
      required this.onClick,
      this.isGrid = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: 140.sp,
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: '${Repository.imageBaseUrl}w500/${movie.backdropPath}',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(
                          Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: isGrid ? 50.sp : 60.sp,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 10.sp, left: 12.sp),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    colorGunMetal.withOpacity(0.2),
                    colorGunMetal.withOpacity(1.0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                child: Text(
                  movie.title,
                  style: !isGrid
                      ? kHeadingStyle.copyWith(color: colorWhite)
                      : kNormalTextStyle.copyWith(color: colorWhite, height: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
