import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import '../../exports.dart';

Widget assetImgWidget({onTap, img, radius, height, width, fit}) {
  return GestureDetector(
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Image.asset(
        img,
        height: height,
        width: width,
        fit: fit ?? BoxFit.fill,
      ),
    ),
  );
}

Widget networkImgWidget({onTap, img, radius, height, width, fit}) {
  return GestureDetector(
    onTap: onTap,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 12),
      child: FancyShimmerImage(
        imageUrl: img,
        height: height,
        width: width,
        boxFit: fit ?? BoxFit.cover,
        errorWidget: assetImgWidget(
          height: height,
          width: width,
        ),
      ),
    ),
  );
}
