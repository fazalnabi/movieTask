import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tentwentytask/config/AppColors.dart';
import 'package:tentwentytask/config/AppStyles.dart';
import 'package:tentwentytask/models/movie/Movie.dart';
import 'package:tentwentytask/network_manager/repository.dart';

class MovieSearchWidget extends StatelessWidget {
  final Movie movie;
  final Function onClick;
  const MovieSearchWidget({
    super.key,
    required this.movie,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: 100.sp,
        child: Row(
          children: [
            Container(
              width: 130.sp,
              height: 100.sp,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    '${Repository.imageBaseUrl}w500/${movie.backdropPath}',
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
            ),
            SizedBox(
              width: 6.sp,
            ),
            SizedBox(
              width: 120.sp,
              child: Text(
                movie.title,
                maxLines: 2,
                style: kNormalTextStyle.copyWith(
                    height: 1.2, color: colorGunMetal),
              ),
            ),
            const Icon(
              Icons.more_horiz,
              color: colorLightBlue,
            )
          ],
        ),
      ),
    );
  }
}
