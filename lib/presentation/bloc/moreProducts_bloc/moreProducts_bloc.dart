import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/moreToExplore_model.dart';
import '../../../domain/repositories/moreProducts_repository.dart';

part 'moreProducts_event.dart';
part 'moreProducts_state.dart';

class MoreProductsBloc extends Bloc<MoreProductsEvent, MoreProductsState> {
  final MoreProductsRepository moreProductsRepository =
      MoreProductsRepository();

  int page = 1;
  bool loadMore = true;

  MoreProductsBloc() : super(MoreProductsState()) {
    on<MoreProductsLoad>((event, emit) async {
      if (state is MoreProductsStateLoading) return;
      final currentState = state;

      List<Result> oldProducts = <Result>[];

      if (currentState is MoreProductsStateLoaded) {
        oldProducts = currentState.products;
      }

      if (event.filter != null) {
        oldProducts = <Result>[];
        loadMore = true;
        page = 1;
        
        await moreProductsRepository
            .getMoreProducts(
                page: page, pageSize: event.pageSize, filter: event.filter)
            .then((data) {
          if (data.error) {
            loadMore = false;
            emit(MoreProductsStateError(oldProducts, data.errorMessage!));
          } else {
            loadMore = false;
            page = 1;
            final posts = data.data!.results!;
            emit(MoreProductsStateLoaded(posts));
          }
        });
      } else {
        if (loadMore) {
          emit(MoreProductsStateLoading(oldProducts, isFirstFetch: page == 1));
          await moreProductsRepository
              .getMoreProducts(page: page, pageSize: event.pageSize)
              .then((data) {
            if (data.error) {
              loadMore = false;
              emit(MoreProductsStateError(oldProducts, data.errorMessage!));
            } else {
              page++;
              final posts = (state as MoreProductsStateLoading).oldProducts;
              posts.addAll(data.data!.results!);

              emit(MoreProductsStateLoaded(posts));
            }
          });
        }
      }
    });
  }
}
