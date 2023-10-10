import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phintraco_assesment/data/attendances/attendances_cubit.dart';
import 'package:phintraco_assesment/data/attendances/data_attendances_cubit.dart';
import 'package:phintraco_assesment/data/auth/login/login_cubit.dart';
import 'package:phintraco_assesment/data/auth/regist/register_cubit.dart';
import 'package:phintraco_assesment/data/profile/data_profile/profile_cubit.dart';
import 'package:phintraco_assesment/utils/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp(appRoute: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoute});

  final AppRouter appRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => AttendancesCubit()),
        BlocProvider(create: (context) => DataAttendancesCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Assesment Phintraco',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          onGenerateRoute: appRoute.onGenerateRoute),
    );
  }
}
