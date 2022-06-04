import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget categoriesItem(String iconUrl, String categoryName) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 60,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xffEBEBEB),
                offset: Offset(0, 6),
                blurRadius: 20.0)
          ],
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: CachedNetworkImage(
        imageUrl: iconUrl,
        width: 40,
        fit: BoxFit.fill,
        progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator.adaptive(value: downloadProgress.progress),
        errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.grey),
     ),
      ),
      SizedBox(
          width: 70,
          child: Text(
            categoryName,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          )),
    ],
  );
}
