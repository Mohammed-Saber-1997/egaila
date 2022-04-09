import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'AppTheme.dart';
import 'SizeConfig.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/salesLocation/sales_location_bloc.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/shareholder_signin/shareholder_sign_in_bloc.dart';
import 'pages/home_page.dart';
import 'repository/home_slider_repository.dart';
import 'repository/search_repository.dart';
import 'repository/shareholder/sales_location_repository.dart';
import 'repository/shareholder/signin_shareholder_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppTheme.buttonsColor));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        MyApp()); //device.DevicePreview(builder: (context) => MyApp())); //MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiBlocProvider(
              providers: [
                BlocProvider<HomeBloc>(create: (BuildContext context) {
                  return HomeBloc(HomeSliderRepositoryImpl())
                    ..add(FetchHomeData("ar"));
                }),
                BlocProvider<SearchBloc>(create: (BuildContext context) {
                  return SearchBloc(SearchRepositoryImpl());
                }),
                BlocProvider<ShareholderSignInBloc>(
                  create: (BuildContext context) =>
                      ShareholderSignInBloc(SignInShareholderRepositoryImpl()),
                ),
                BlocProvider<SalesLocationBloc>(
                  create: (BuildContext context) =>
                      SalesLocationBloc(SalesLocationRepositoryImpl())
                        ..add(GetSalesLocation()),
                ),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
//              builder: device.DevicePreview.appBuilder,
                builder: (context, child) {
                  return MediaQuery(
                    child: child!,
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  );
                },
                title: "KUCCS",
                theme: AppTheme.lightTheme,
                home: HomePage(),
              ),
            );
          },
        );
      },
    );
  }
}
