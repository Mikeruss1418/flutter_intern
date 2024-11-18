import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qn_2/blocs/cart/cart_bloc.dart';
import 'package:qn_2/blocs/product/product_bloc.dart';
import 'package:qn_2/screens/landing_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()..add(FetchProductEvent())),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: const MaterialApp(
        title: 'Shopping Cart App',
        home: ProductListScreen(),
      ),
    );
  }
}
