part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class AddtoCartEvent extends CartEvent {
  final Product product;

  AddtoCartEvent({required this.product});
}

class RemoveFromCartEvent extends CartEvent {
  final int productId;

  RemoveFromCartEvent({required this.productId});
}
