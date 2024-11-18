part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

final class ProductInitial extends ProductState {}

class ProductFetchingState extends ProductState {}

class ProductFetchedState extends ProductState {
  final List<Product> products;

  ProductFetchedState({required this.products});
}

class ProductFetchFailState extends ProductState {
  final String errmsg;

  ProductFetchFailState({required this.errmsg});
}
