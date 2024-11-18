part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

final class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<Product> products;

  CartLoadedState({required this.products});
}

class CartErrorState extends CartState {
  final String errormsg;

  CartErrorState({required this.errormsg});
}
