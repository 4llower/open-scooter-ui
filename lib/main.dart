import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scanner_cubit/scanner_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/pages/auth_page.dart';
import 'feature/presentation/bloc/balance_cubit/balance_cubit.dart';
import 'feature/presentation/pages/balance_page.dart';
import 'feature/presentation/pages/scan_page.dart';
import 'locator_service.dart' as di;

import 'common/app_colors.dart';
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScooterCubit>(
            create: (context) => sl<ScooterCubit>()..loadScooters()),
        BlocProvider<UserCubit>(
            create: (context) => sl<UserCubit>()..getTokenFromLocalStorage()),
        BlocProvider<ScannerCubit>(
          create: (context) => sl<ScannerCubit>(),
        ),
        BlocProvider<BalanceCubit>(
          create: (context) => sl<BalanceCubit>()..loadUser("228"),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthPage(),
          '/scan': (context) => ScanPage(),
          '/balance': (context) => BalancePage()
        },
      ),
    );
  }
}
