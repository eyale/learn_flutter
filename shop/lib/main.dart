import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth_provider.dart';

import './providers/cart.dart';
import './providers/order.dart';
import './providers/products_provider.dart';
import './screens/auth.dart';
import './screens/cart.dart';
import './screens/edit_products.dart';
import './screens/orders.dart';
import './screens/product_details.dart';
import './screens/products_overview.dart';
import './screens/user_products.dart';
import './widgets/splash_screen.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        // Below: is just an example
        // how to pass data from One Provider to Another
        ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products(),
            update: (ctx, authData, prevStateProducts) {
              return Products(
                authToken: authData.token,
                localItems: prevStateProducts!.items,
              );
            }),
        ChangeNotifierProvider(create: (_) => Order()),
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) {
          debugPrint('auth.isAuth: ${auth.isAuth}'.toUpperCase());
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: Colors.pinkAccent, primary: Colors.blueGrey),
                fontFamily: 'Lato'),
            home: auth.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.autoLogin(),
                    builder: (ctx, authResultSnapshot) {
                      if (authResultSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const SplashScreen();
                      }
                      return const AuthScreen();
                    },
                  ),
            routes: {
              AuthScreen.routeName: (_) => const AuthScreen(),
              ProductDetailsScreen.routeName: (_) =>
                  const ProductDetailsScreen(),
              CartScreen.routeName: (_) => const CartScreen(),
              OrdersScreen.routeName: (_) => const OrdersScreen(),
              UserProductsScreen.routeName: (_) => const UserProductsScreen(),
              EditProductsScreen.routeName: (_) => const EditProductsScreen(),
            },
          );
        },
      ),
    );
  }
}
