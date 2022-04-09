import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/social_news/social_news_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/utils/date_time_utils.dart';
import 'package:eqaila_app/widgets/news_list_view_item.dart';

import '../AppTheme.dart';

class SocialNewsPage extends StatelessWidget {
  final int? sectionId;
  final String? sectionName;

  SocialNewsPage(this.sectionId, this.sectionName);

  SocialNewsBloc? socialNewsBloc;

  @override
  Widget build(BuildContext context) {
    socialNewsBloc = BlocProvider.of<SocialNewsBloc>(context);
    socialNewsBloc!.add(FetchSocialNews("ar", sectionId));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF2FA),
        appBar: AppBar(
          title: Text(sectionName!, style: AppTheme.appBarStyle),
        ),
        body: Center(
          child: BlocBuilder<SocialNewsBloc, SocialNewsState>(
            bloc: socialNewsBloc,
            builder: (context, state) {
              if (state is SocialNewsLoading) {
                return AppTheme.showLoadingSpinKit();
              } else if (state is SocialNewsLoaded) {
                return socialNewsWidget(context, state.model);
              } else if (state is SocialNewsError) {
                return Text(state.errorMessage);
              } else {
                return AppTheme.showLoadingSpinKit();
              }
            },
          ),
        ),
      ),
    );
  }

  /// social News ListView Widget
  Widget socialNewsWidget(BuildContext context, CategoryModel model) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: model.results!.length,
        itemBuilder: (BuildContext context, int index) {
          return NewsListViewItem(
            index: index,
            model: model,
            dateFormatter: DateTimeUtils.dateFormatter,
          );
        },
      ),
    );
  }

  //TODO:
  dispose() {
    socialNewsBloc!.close();
  }
}
