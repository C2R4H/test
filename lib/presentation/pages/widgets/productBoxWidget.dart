import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../product_page.dart';

Widget productBoxWidget(BuildContext context, String productName,
    String productBrand, double productPrice, String imageURL, int id) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage(id, imageURL)),
      );
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width / 2.2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: CachedNetworkImage(
                  fit: BoxFit.fitHeight,
                  imageUrl: imageURL,
                  placeholder: (context, url) => SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF7F7F7),
                      ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.star_border,color: Colors.black,),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(
          productName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 5),
        Text(
          productBrand,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xff919191),
          ),
        ),
        SizedBox(height: 5),
        productPrice != 0
            ? Text(
                '\$$productPrice',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff00C569),
                ),
              )
            : Container(),
      ],
    ),
  );
}
