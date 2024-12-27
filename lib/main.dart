import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:send_money/bloc/auth_bloc/auth_bloc.dart';
import 'package:send_money/bloc/create_transaction_bloc/transaction_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/home_bloc/home_toggle_bloc.dart';
import 'package:send_money/bloc/network_block/network_bloc.dart';
import 'package:send_money/bloc/network_block/network_event.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_bloc.dart';
import 'package:send_money/data/repository/auth_repo.dart';
import 'package:send_money/data/repository/transaction_repo.dart';
import 'package:send_money/routes/PageRoutes.dart';
import 'package:send_money/routes/RoutesPath.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  //Http overrides to handle certificates related issues....
  // HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  ///dependency innjection- Creates Singleton objects
  final getIt = GetIt.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {

          return MultiBlocProvider(
            providers: [
              BlocProvider<NetworkBloc>(create: (context) => NetworkBloc()..add(NetworkObserve())),
              BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepo: AuthRepo())),
              BlocProvider<HomeBloc>(create: (context) => HomeBloc(authRepo: AuthRepo())),
              BlocProvider<HomeToggleBloc>(create: (context) => HomeToggleBloc()),
              BlocProvider<TransactionBloc>(create: (context) => TransactionBloc(transactionRepo: getIt.registerSingleton<TransactionRepo>(TransactionRepo()))),
              BlocProvider<TransactionHistoryBloc>(create: (context) => TransactionHistoryBloc(transactionRepo: TransactionRepo()))
            ],
            child: MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                onGenerateRoute: PageRouter.generateRoute,
                initialRoute: RoutesPath.SPLASH
            ),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}