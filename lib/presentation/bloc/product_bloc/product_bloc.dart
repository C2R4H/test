import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/repositories/product_repository.dart';

part 'product_state.dart';
part 'product_event.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState>{

  final ProductRepository _productRepository = ProductRepository();

  ProductBloc() : super(ProductState()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductStateLoading());

      await _productRepository.getProductData(event.id).then((data){
        print(data.errorMessage);
        if(data.error){
          emit(ProductStateError(data.errorMessage!));
        }else{
          print(data.data!.name);
          emit(ProductStateLoaded(data.data!));
        }
      });
    });
  }
}

