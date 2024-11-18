import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qn_2/models/product_model.dart';
import 'package:qn_2/services/api_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProductEvent>(
      (event, emit) async {
        emit(ProductFetchingState());
        try {
          final products = await ApiService.fetchProducts();
          emit(ProductFetchedState(products: products));
        } catch (e) {
          emit(ProductFetchFailState(errmsg: e.toString()));
        }
      },
    );
  }
}
