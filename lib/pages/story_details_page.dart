import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:eqaila_app/bloc/story_details/story_details_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/utils/date_time_utils.dart';
import 'package:eqaila_app/utils/strings.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';
import '../constants.dart';

class StoryDetailsPage extends StatelessWidget {
  final int? storyId;
  StoryDetailsModel? detailsModel;

  StoryDetailsPage(this.storyId);

  @override
  Widget build(BuildContext context) {
    final StoryDetailsBloc detailsBloc =
        BlocProvider.of<StoryDetailsBloc>(context);
    detailsBloc.add(FetchStoryDetails("ar", storyId));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.appBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.details, style: AppTheme.appBarStyle),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (detailsModel != null) {
                    detailsBloc.add(ShareStory(detailsModel));
                  }
                },
                child: Icon(
                  Icons.share,
                  size: 6 * SizeConfig.imageSizeMultiplier,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<StoryDetailsBloc, StoryDetailsState>(
            bloc: detailsBloc,
            builder: (context, state) {
              if (state is DetailsLoading) {
                return AppTheme.showLoadingSpinKit();
              } else if (state is DetailsDataLoaded) {
                return detailsWidget(context, state.model);
              } else if (state is DetailsError) {
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

  /// details Widget
  Widget detailsWidget(BuildContext context, StoryDetailsModel _detailsModel) {
    this.detailsModel = _detailsModel;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 9 / 6,
              child: Container(
                height: 25 * SizeConfig.heightMultiplier,
                width: 95 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "$root/Content/Upload/Slider/${_detailsModel.results!.pictureName}",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Text(
                _detailsModel.results!.title!,
                overflow: TextOverflow.ellipsis,
                style: AppTheme.textBoldBlackColorStyle,
                maxLines: 3,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: .5,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    DateTimeUtils.dateFormatter
                        .format(
                            DateTime.parse(_detailsModel.results!.publishDate!))
                        .toString(),
                    style: AppTheme.textOrangeColorStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppTheme.appBackgroundColor,
            padding: EdgeInsets.all(20.0),
            child: HtmlWidget(
              _detailsModel.results!.body!,
              webView: true,
              webViewJs: true,
            ),
          ),
        ],
      ),
    );
  }
}
