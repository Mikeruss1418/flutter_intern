import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qn_2/models/product_model.dart';
import 'package:qn_2/services/shared_prefs.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddtoCartEvent>(
      (event, emit) async {
        emit(CartLoadingState());
        try {
          await SharedPreferencesUtil.addToCart(event.product);
          final cartItems = await SharedPreferencesUtil.getCartItems();
          emit(CartLoadedState(products: cartItems));
        } catch (e) {
          emit(CartErrorState(errormsg: e.toString()));
        }
      },
    );

    on<RemoveFromCartEvent>(
      (event, emit) async {
        emit(CartLoadingState());
        try {
          await SharedPreferencesUtil.removeFromCart(event.productId);
          final cartItems = await SharedPreferencesUtil.getCartItems();
          emit(CartLoadedState(products: cartItems));
        } catch (e) {
          emit(CartErrorState(errormsg: e.toString()));
        }
      },
    );
  }
}
