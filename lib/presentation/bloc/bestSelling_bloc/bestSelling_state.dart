part of 'bestSelling_bloc.dart';

class BestSellingState{}

class BestSellingStateLoading extends BestSellingState{}

class BestSellingStateLoaded extends BestSellingState{
  final BestSellingModel bestSellingModel;
  BestSellingStateLoaded(this.bestSellingModel);
}

class BestSellingStateError extends BestSellingState{
  final String error;
  BestSellingStateError(this.error);
}



