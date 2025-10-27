import 'package:finance_guard/features/welcome%20&%20balance%20cubit/pages/welcome_page.dart';
import 'package:finance_guard/features/welcome%20&%20balance%20cubit/repo/balance_repo.dart';
import 'package:finance_guard/servise_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'features/budget/bloc/goal/goal_cubit.dart';
import 'features/budget/domain/model/goal/goal_model.dart';
import 'features/budget/domain/model/limit/limits_model.dart';
import 'features/categories/domain/model/categories_model.dart';
import 'features/categories/presentation/bloc/categories_cubit.dart';
import 'features/home/bloc/transaction_bloc/transaction_cubit.dart';
import 'features/home/data/model/transaction_model.dart';
import 'features/home/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(LimitsModelAdapter());
  Hive.registerAdapter(GoalModelAdapter());
  await setupServiceLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GoalsCubit>()..addDefaultGoal(),
        ),
        BlocProvider<TransactionCubit>(
          create: (_) => sl<TransactionCubit>(),
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => sl<CategoryCubit>()..loadDefaultCategories(),
        ),
      ],
      child: const MyApp(),
    ),
  );

  }

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 973),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF0A0E21),
              textTheme: Typography.whiteMountainView,

              fontFamily: 'SFPro'
          ),
          home: Builder(
            builder: (context) {
              final balance = sl<BalanceRepo>().getTotal(); // без await

              if (balance == 0) {
                return WelcomePage();
              } else {
                return HomePage();
              }
            },
          )
          ,
        );
      },
    );
  }
}

