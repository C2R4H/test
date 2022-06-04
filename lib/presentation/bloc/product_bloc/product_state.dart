part of 'product_bloc.dart';

class ProductState{}

class ProductStateLoading extends ProductState{}

class ProductStateLoaded extends ProductState{
  final Product productModel;
  ProductStateLoaded(this.productModel);
}

class ProductStateError extends ProductState{
  final String error;
  ProductStateError(this.error);
}
