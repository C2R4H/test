import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc/product_bloc.dart';
import '../../data/models/product_model.dart';

class ProductPage extends StatefulWidget {
  int id;
  String imageURL;
  ProductPage(this.id, this.imageURL);

  @override
  ProductPageState createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  final ProductBloc _productBloc = ProductBloc();
  bool isReadMore = false;

  @override
  void initState() {
    _productBloc.add(ProductEvent(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: BlocProvider(
        create: (_) => _productBloc,
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductStateLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is ProductStateLoaded) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 80,
                    child: CustomScrollView(
                      shrinkWrap: true,
                      slivers: [
                        SliverAppBar(
                          iconTheme: IconThemeData(
                            color: Colors.black,
                          ),
                          flexibleSpace: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                  child: Hero(
                                tag: widget.id,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: widget.imageURL,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              )),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xffF7F7F7),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.star_border,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          expandedHeight:
                              MediaQuery.of(context).size.height / 1.8,
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.productModel.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                width: MediaQuery.of(context).size.width / 2.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xffEBEBEB)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Size'),
                                    Flexible(
                                      child: Text(
                                        state.productModel.size,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 15),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                width: MediaQuery.of(context).size.width / 2.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Color(0xffEBEBEB)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Colour'),
                                    Flexible(
                                      child: Text(
                                        state.productModel.colour,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              state.productModel.details,
                              maxLines: isReadMore ? null : 4,
                              overflow: isReadMore
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isReadMore = !isReadMore;
                                });
                              },
                              child: Text(
                                isReadMore ? 'Read Less' : 'Read More',
                                style: TextStyle(
                                  color: Color(0xff00C569),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Reviews',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          ListView.builder(
                              itemCount: state.productModel.reviews.length,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var item = state.productModel.reviews[index];
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        state.productModel.reviews[index].image,
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: Text(
                                            "${item.firstName} ${item.lastName}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          height: 30,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: item.rating,
                                            itemBuilder: (context, index) {
                                              return const Icon(
                                                Icons.star,
                                                color: Color(0xffEBE300),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      item.message,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ])),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'PRICE',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '\$${state.productModel.price}',
                                style: TextStyle(
                                  color: Color(0xff00C569),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xff00C569),
                            ),
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ProductStateError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'There was an error. Please check your internet connection and try again.',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
