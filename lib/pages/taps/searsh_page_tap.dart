import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:eqaila_app/bloc/search/search_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/utils/date_time_utils.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/news_list_view_item.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';

class SearchPageTap extends StatefulWidget {
  final SectionsModel? sections;

  SearchPageTap(this.sections);

  @override
  _SearchPageTapState createState() => _SearchPageTapState();
}

class _SearchPageTapState extends State<SearchPageTap> {
  final TextEditingController baseController = TextEditingController();
  String? Error;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarWidget() as PreferredSizeWidget?,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: AppTheme.buttonsColor,
              child: Padding(
                padding: EdgeInsets.all(3 * SizeConfig.imageSizeMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: searchTextFormFieldWidget(context)),
                    SizedBox(width: 10),
                    searchButtonWidget(context),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return AppTheme.showLoadingSpinKit();
                    } else if (state is SearchResultLoaded) {
                      if (state.model.results!.isEmpty) {
                        return noResultDataWidget();
                      } else {
                        return searchResultWidget(state.model);
                      }
                    } else if (state is SearchResultError) {
                      return Text(state.errorMessage);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// App Bar
  Widget appBarWidget() {
    return AppBar(
      elevation: 0.0,
      title: Text(Strings.Search, style: AppTheme.appBarStyle),
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/search_drawer.png"),
              color: Colors.white,
              size: 6 * SizeConfig.imageSizeMultiplier,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              //SearchState.initCondition();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  /// search Text Form Field Widget
  Widget searchTextFormFieldWidget(BuildContext context) => TextFormField(
        cursorColor: AppTheme.gg,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (value) {
          enterValue(context, value);
        },
        style: AppTheme.textStyleBlack16w600,
        controller: baseController,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: Strings.Search,
          hintStyle: TextStyle(
            color: AppTheme.subTitleTextColor,
          ),
          errorText: Error,
          filled: true,
          fillColor: AppTheme.colorPrimaryB,
          border: AppTheme.borderGray(),
          errorBorder: AppTheme.borderGray(),
          focusedBorder: AppTheme.borderGray(),
          enabledBorder: AppTheme.borderGray(),
          focusedErrorBorder: AppTheme.borderGray(),
        ),
      );

  /// search Button Widget
  Widget searchButtonWidget(BuildContext context) {
    return ClipOval(
      child: Material(
        elevation: 5.0,
        color: AppTheme.appBackgroundColor, // button color
        child: InkWell(
          splashColor: Colors.white, // inkwell color
          child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                color: AppTheme.buttonsColor,
              )),
          onTap: () {
            enterValue(context, baseController.text.trim());
          },
        ),
      ),
    );
  }

  /// search Result ListView Widget
  Widget searchResultWidget(AdvancedSearchModel state) {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: state.results!.length,
          itemBuilder: (BuildContext context, int index) {
            return NewsListViewItem(
              index: index,
              model: state,
              dateFormatter: DateTimeUtils.dateFormatter,
            );
          }),
    );
  }

  Widget noResultDataWidget() => Center(
        child: Text(
          'لا يوجد نتيجة لكلمة البحث \n  \"${baseController.text}\"',
          textAlign: TextAlign.center,
          style: AppTheme.textStyleBlack16w600,
        ),
      );

  int _sectionid = -1;
  String _Picked_from_senddate = "05-01-2010";
  String _Picked_to_senddate = "05-01-2040";

  void enterValue(BuildContext context, String value) {
    value = baseController.value.text.trim();
    if (value.length > 1) {
      Error = "";
      final searchBloc = BlocProvider.of<SearchBloc>(context);
      searchBloc.add(SimpleSearch("ar", value, _sectionid,
          _Picked_from_senddate, _Picked_to_senddate, 0));
    } else {
      Error = "برجاء اذخال كلمه بحث مناسبه";
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
