part of 'bestSelling_bloc.dart';

class BestSellingEvent{
  int page;
  int pageSize;
  String? filter;
  BestSellingEvent({required this.page,required this.pageSize,this.filter});
}
