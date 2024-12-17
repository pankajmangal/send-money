import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:send_money/bloc/home_bloc/home_bloc.dart';
import 'package:send_money/bloc/transaction_history_bloc/transaction_history_bloc.dart';
import 'package:send_money/data/repository/transaction_history_repo.dart';
import 'package:send_money/routes/PageRoutes.dart';
import 'package:send_money/routes/RoutesPath.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
              BlocProvider<TransactionHistoryBloc>(create: (context) =>
                  TransactionHistoryBloc(transactionHistoryRepo: TransactionHistoryRepo()))
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