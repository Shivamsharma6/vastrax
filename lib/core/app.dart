import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/product/data/repositories/product_repository.dart';
import '../features/product/presentation/providers/product_provider.dart';
import '../features/payment/presentation/providers/cart_provider.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';

class VastraxApp extends StatelessWidget {
  const VastraxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductRepository()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp.router(
        title: 'Vastrax',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routerConfig: appRouter,
      ),
    );
  }
}
