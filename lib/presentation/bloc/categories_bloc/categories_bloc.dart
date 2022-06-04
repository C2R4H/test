import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/categories_repository.dart';
import '../../../data/models/categories_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository = CategoriesRepository();


  CategoriesBloc() : super(CategoriesState()) {
    CategoriesModel _categoriesModel;

    on<CategoriesEventGet>((event, emit) async {
      emit(CategoriesStateLoading());

      await categoriesRepository.getCategories(page:event.page, pageSize :event.pageSize).then((data) {
        if (data.error) {
          emit(CategoriesStateError(data.errorMessage!));
        } else {
          _categoriesModel = data.data!;
          emit(CategoriesStateLoaded(categoriesModel: data.data!));
        }
      });
    });

    on<CategoriesChoosed>((event,emit){
      emit(CategoriesStateLoaded(categoryName: event.categoryName,categoriesModel: event.categoriesModel));
    });
  }

}
