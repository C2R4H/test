part of 'moreProducts_bloc.dart';

class MoreProductsEvent{
}

class MoreProductsLoad extends MoreProductsEvent{
  int pageSize;
  String? filter;
  MoreProductsLoad({
    required this.pageSize,
    this.filter,
  });
}

class MoreProductsFilterLoad extends MoreProductsEvent{
  String filter;
  MoreProductsFilterLoad(this.filter);
}
