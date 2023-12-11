import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/presentation/utils/k_strings.dart';
import 'presentation/router/route_names.dart';
import 'presentation/widget/custom_theme.dart';
import 'state_injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await StateInjector.init();
  runApp(const RealEstate());
}

class RealEstate extends StatelessWidget {
  const RealEstate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiRepositoryProvider(
          providers: StateInjector.repositoryProviders,
          child: MultiBlocProvider(
            providers: StateInjector.blocProviders,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: KString.appName,
              onGenerateRoute: RouteNames.generateRoutes,
              theme: CustomTheme.theme,
              initialRoute: RouteNames.splashScreen,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
