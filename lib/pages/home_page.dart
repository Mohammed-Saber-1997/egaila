import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eqaila_app/bloc/home/home_bloc.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';
import 'taps/home_page_tap.dart';
import 'taps/navigation_drawer_page_tap.dart';
import 'taps/searsh_page_tap.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          backgroundColor: AppTheme.appBackgroundColor,
          bottomNavigationBar: bottomNavigationBarWidget(context),
          body: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return AppTheme.showLoadingSpinKit();
                } else if (state is HomeDataLoaded) {
                  return bottomNavBarTapPages(state);
                } else if (state is HomeError) {
                  return Text(state.errorMessage);
                } else {
                  return AppTheme.showLoadingSpinKit();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  /// bottom Navigation Bar Taps Pages
  Widget bottomNavBarTapPages(HomeDataLoaded state) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            NavigationDrawerPageTap(state.model.sections),
            HomePageTap(state.model.sliderNews),
            SearchPageTap(state.model.sections),
          ]),
    );
  }

  /// bottom Navigation Bar Taps
  Widget bottomNavigationBarWidget(BuildContext context) {
    return SafeArea(
      bottom: true,
      right: true,
      left: true,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.fromLTRB(
              1 * SizeConfig.heightMultiplier,
              0.0,
              1 * SizeConfig.heightMultiplier,
              1.5 * SizeConfig.heightMultiplier),
          height: 7 * SizeConfig.heightMultiplier,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: AppTheme.buttonsColor,
            shadowColor: AppTheme.buttonsColor,
            elevation: 8.0,
            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
            child: TabBar(
              isScrollable: false,
              labelColor: AppTheme.secondary,
              unselectedLabelColor: Colors.white,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppTheme.appBackgroundColor,
                  width: 3.0,
                ),
                insets: EdgeInsets.fromLTRB(
                    30.0, 0.0, 30.0, 6 * SizeConfig.heightMultiplier),
              ),
              // labelStyle: ,
              tabs: <Widget>[
                bottomBarItemWidget(Icons.settings),
                bottomBarItemWidget(Icons.home),
                bottomBarItemWidget(Icons.search),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// bottomBar Item Widget
  Widget bottomBarItemWidget(IconData icon) {
    return Container(
      padding: EdgeInsets.only(top: 1 * SizeConfig.heightMultiplier),
      child: Center(
        child: Icon(
          icon,
          size: 7 * SizeConfig.imageSizeMultiplier,
        ),
      ),
    );
  }
}
