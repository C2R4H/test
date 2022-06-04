import 'package:flutter/material.dart';

Widget favoriteWidget() {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffF7F7F7),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.star_border,
          color: Colors.black,
        ),
      ),
    ),
  );
}
