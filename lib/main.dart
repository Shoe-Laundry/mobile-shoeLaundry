import 'package:shoelaundry/data/datasources/auth_local_datasource.dart';
import 'package:shoelaundry/data/datasources/auth_remote_datasource.dart';
import 'package:shoelaundry/data/datasources/midtrans_remote_datasource.dart';
import 'package:shoelaundry/data/datasources/order_remote_datasource.dart';
import 'package:shoelaundry/data/datasources/product_remote_datasource.dart';
import 'package:shoelaundry/presentation/auth/bloc/registration/registration_bloc.dart';
import 'package:shoelaundry/presentation/history/bloc/history/history_bloc.dart';
import 'package:shoelaundry/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:shoelaundry/presentation/home/bloc/product/product_bloc.dart';
import 'package:shoelaundry/presentation/home/pages/dashboard_page.dart';
import 'package:shoelaundry/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:shoelaundry/presentation/onboarding/pages/onboarding.dart';
import 'package:shoelaundry/presentation/order/bloc/order/order_bloc.dart';
import 'package:shoelaundry/presentation/order/bloc/qris/qris_bloc.dart';
import 'package:shoelaundry/presentation/setting/bloc/sync_order/sync_order_bloc.dart';
import 'package:shoelaundry/presentation/setting/bloc/update_user/update_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'core/constants/colors.dart';
import 'presentation/auth/bloc/login/login_bloc.dart';
import 'presentation/home/bloc/logout/logout_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingBloc()),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource())
            ..add(const ProductEvent.fetchLocal()),
        ),
        BlocProvider(create: (context) => CheckoutBloc()),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => QrisBloc(MidtransRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(),
        ),
        BlocProvider(
          create: (context) => SyncOrderBloc(OrderRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => UpdateUserBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: AppBarTheme(
              color: AppColors.primary,
              elevation: 0,
              titleTextStyle: GoogleFonts.poppins(
                color: AppColors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              iconTheme: const IconThemeData(
                color: AppColors.black,
              ),
            ),
            scaffoldBackgroundColor: AppColors.white),
        //cek auth
        home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isAuth(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return const DashboardPage();
              } else {
                return Onboarding();
              }
            }),
      ),
    );
  }
}
