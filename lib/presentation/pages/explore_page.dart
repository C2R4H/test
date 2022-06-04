import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/categories_bloc/categories_bloc.dart';
import '../bloc/bestSelling_bloc/bestSelling_bloc.dart';
import '../bloc/moreProducts_bloc/moreProducts_bloc.dart';

import '../../data/models/moreToExplore_model.dart';

import 'widgets/productBoxWidget.dart';
import 'widgets/categoriesItem.dart';

class ExplorePage extends StatefulWidget {
  @override
  ExplorePageState createState() => ExplorePageState();
}

class ExplorePageState extends State<ExplorePage> {
  final ScrollController _scrollController = ScrollController();

  final CategoriesBloc _categoriesBloc = CategoriesBloc();
  final MoreProductsBloc _moreProductsBloc = MoreProductsBloc();
  final BestSellingBloc _bestSellingBloc = BestSellingBloc();

  void scrollControllerGrid({String? filter}) {
    _scrollController.addListener(
      () {
        if (_scrollController.position.atEdge &&
            _scrollController.position.pixels != 0) {
          if (filter == null) {
            _moreProductsBloc.add(MoreProductsLoad(pageSize: 10));
          } else {
            _moreProductsBloc
                .add(MoreProductsLoad(pageSize: 10, filter: filter));
          }
        }
      },
    );
  }

  @override
  void initState() {
    scrollControllerGrid();
    _categoriesBloc.add(CategoriesEventGet(page: 1, pageSize: 10));
    _bestSellingBloc.add(BestSellingEvent(page: 1, pageSize: 10));
    _moreProductsBloc.add(MoreProductsLoad(pageSize: 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffFAFaFa),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          controller: _scrollController,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xffF1F1F1),
                    ),
                    height: 40,
                    width: width / 1.3,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      onChanged: (text) {
                        _moreProductsBloc
                            .add(MoreProductsLoad(pageSize: 10, filter: text));
                        _bestSellingBloc.add(BestSellingEvent(
                            page: 1, pageSize: 10, filter: text));
                      },
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Color(0xff00C569),
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon:
                          Icon(Icons.camera_alt_outlined, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            categoriesWidget(),
          ],
        ),
      ),
    );
  }

  Widget categoriesWidget() {
    return BlocProvider(
      create: (_) => _categoriesBloc,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
            if(state is CategoriesStateError){
                return const Center(
                    child: Text(
                        textAlign: TextAlign.center,
                        'There was an error. Please check your internet connection and try again.'));
            }
            if (state is CategoriesStateLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is CategoriesStateLoaded) {
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categoriesModel.results.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _categoriesBloc.add(CategoriesChoosed(
                                state.categoriesModel.results[index].name,
                                state.categoriesModel));
                          },
                          child: categoriesItem(
                            state.categoriesModel.results[index].icon,
                            state.categoriesModel.results[index].name,
                          ),
                        );
                      },
                    ),
                  ),
                  state.categoryName != null
                      ? bestSellingWidget(filter: state.categoryName)
                      : bestSellingWidget(),
                  state.categoryName != null
                      ? moreToExploreWidget(
                          context: context, filter: state.categoryName)
                      : moreToExploreWidget(context: context),
                ],
              );
            }

            return Container();
          }),
        ],
      ),
    );
  }

  Widget moreToExploreWidget({required BuildContext context, String? filter}) {
    if (filter != null) {
      _moreProductsBloc.add(MoreProductsLoad(pageSize: 10, filter: filter));
    }
    return BlocProvider(
      create: (_) => _moreProductsBloc,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            filter != null ? filter : 'More to explore',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<MoreProductsBloc, MoreProductsState>(
              builder: (context, state) {
            List<Result> products = [];
            bool isLoading = false;

            if (state is MoreProductsStateLoading && state.isFirstFetch) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is MoreProductsStateLoading) {
              isLoading = true;
              products = state.oldProducts;
            }
            if (state is MoreProductsStateLoaded) {
              products = state.products;
            }
            if (state is MoreProductsStateError) {
              products = state.oldProducts;
              if (products.isEmpty) {
                return const Center(
                    child: Text(
                        textAlign: TextAlign.center,
                        'There was an error. Please check you internet connection and try again.'));
              }
            }
            if (state is MoreProductsFilterLoaded) {
              products = state.products;
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
              ),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: products.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < products.length) {
                  return productBoxWidget(
                    context,
                    products[index].name,
                    products[index].category.name,
                    products[index].price,
                    products[index].mainImage,
                    products[index].id,
                  );
                } else {
                  scrollControllerGrid(filter: filter);
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }
              },
            );
          }),
        ],
      ),
    );
  }

  Widget bestSellingWidget({String? filter}) {
    if (filter != null) {
      _bestSellingBloc
          .add(BestSellingEvent(page: 1, pageSize: 10, filter: filter));
    }
    return BlocProvider(
      create: (_) => _bestSellingBloc,
      child: BlocBuilder<BestSellingBloc, BestSellingState>(
          builder: (context, state) {
        if (state is BestSellingStateLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is BestSellingStateLoaded) {
          if (state.bestSellingModel.results.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Best Selling',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text('See all'),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.bestSellingModel.results.length,
                    itemBuilder: (context, index) {
                      return productBoxWidget(
                        context,
                        state.bestSellingModel.results[index].name,
                        state.bestSellingModel.results[index].details,
                        state.bestSellingModel.results[index].price,
                        state.bestSellingModel.results[index].category.icon,
                        state.bestSellingModel.results[index].id,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        }
        if (state is BestSellingStateError) {
          return const Center(
              child: Text(
                  textAlign: TextAlign.center,
                  'There was an error. Please check your internet connection and try again.'));
        }
        return Container();
      }),
    );
  }
}
