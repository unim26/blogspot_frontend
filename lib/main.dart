import 'package:blogspot/core/Routes/routes.dart';
import 'package:blogspot/features/auth/presentation/blocs/obscure_password/obscure_password_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/local/local_user_cubit.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/local/timer_provider.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/otp_bloc/otp_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/password_bloc/password_bloc.dart';
import 'package:blogspot/features/auth/presentation/blocs/user/remote/user_bloc/remote_user_bloc.dart';
import 'package:blogspot/features/auth/presentation/pages/on_boarding_page.dart';
import 'package:blogspot/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'features/home/Presentation/pages/home_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(MultiBlocProvider(
    providers: [
      //obscure password bloc
      BlocProvider(
        create: (context) => ObscurePasswordBloc(),
      ),

      // remoteuser bloc
      BlocProvider(
        create: (context) => locator<RemoteUserBloc>(),
      ),

      //local user cubit
      BlocProvider(
        create: (context) => locator<LocalUserCubit>()..isUserLoggedIn(),
      ),

      //otp bloc
      BlocProvider(
        create: (context) => locator<OtpBloc>(),
      ),

      //password bloc
      BlocProvider(
        create: (context) => locator<PasswordBloc>(),
      ),

      ChangeNotifierProvider(
        create: (contex) => locator<TimerProvider>(),
      )
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: MyRoutes().routes,
      home: BlocBuilder<LocalUserCubit, LocalUserState>(
        builder: (context, state) {
          if (state == LocalUserState.loggedIn) {
            return HomePage();
          } else {
            return OnBoardingPage();
          }
        },
      ),
    );
  }
}
