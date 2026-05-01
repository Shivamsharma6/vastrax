import 'package:go_router/go_router.dart';
import '../../features/product/presentation/screens/collection_detail_screen.dart';
import '../../features/product/presentation/screens/home_screen.dart';
import '../../features/product/presentation/screens/product_detail_screen.dart';
import '../../features/payment/presentation/screens/cart_screen.dart';
import '../../features/payment/presentation/screens/checkout_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/collection/:id',
      name: 'collection-detail',
      builder: (context, state) {
        final collectionId = state.pathParameters['id']!;
        return CollectionDetailScreen(collectionId: collectionId);
      },
    ),
    GoRoute(
      path: '/product/:id',
      name: 'product-detail',
      builder: (context, state) {
        final productId = state.pathParameters['id']!;
        return ProductDetailScreen(productId: productId);
      },
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/checkout',
      name: 'checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
  ],
);
