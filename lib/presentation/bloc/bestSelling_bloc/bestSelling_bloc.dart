import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/bestSelling_model.dart';
import '../../../data/network/network_service.dart';

part 'bestSelling_state.dart';
part 'bestSelling_event.dart';

class BestSellingBloc extends Bloc<BestSellingEvent,BestSellingState>{
  BestSellingBloc() : super(BestSellingState()){

    on<BestSellingEvent>((event, emit) async {
      NetworkService networkService = NetworkService();
      emit(BestSellingStateLoading());

      await networkService.getBestSelling(page:event.page,pageSize: event.pageSize,filter: event.filter).then((data){
        if(data.error){
          emit(BestSellingStateError(data.errorMessage!));
        } else {
          emit(BestSellingStateLoaded(data.data!));
        }
      });
    });

  }
}


