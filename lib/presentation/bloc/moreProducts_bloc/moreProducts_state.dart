part of 'moreProducts_bloc.dart';

class MoreProductsState{}

class MoreProductsStateLoading extends MoreProductsState{
  final List<Result> oldProducts;
  final bool isFirstFetch;
  MoreProductsStateLoading(this.oldProducts,{this.isFirstFetch=false});
}

class MoreProductsStateLoaded extends MoreProductsState{
  final List<Result> products;
  MoreProductsStateLoaded(this.products);
}

class MoreProductsStateError extends MoreProductsState{
  final List<Result> oldProducts;
  String error;
  MoreProductsStateError(this.oldProducts,this.error);
}

class MoreProductsFilterLoaded extends MoreProductsState{
  final List<Result> products;
  MoreProductsFilterLoaded(this.products);
}
