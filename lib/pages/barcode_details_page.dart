import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:eqaila_app/bloc/scanner_search/search_scanner_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/utils/strings.dart';

import '../AppTheme.dart';

class BarcodeDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.colorWhitC,
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.searchResult, style: AppTheme.appBarStyle),
        ),
        body: BlocBuilder<SearchScannerBloc, SearchScannerState>(
          builder: (context, state) {
            if (state is SearchScannerLoading) {
              return AppTheme.showLoadingSpinKit();
            } else if (state is SearchScannerLoaded) {
              return bodyWidget(state.modelList);
            } else if (state is SearchScannerError) {
              return Center(
                child: Text(
                  Strings.noProductData,
                  style: AppTheme.titleTextStyle,
                ),
              );
            } else {
              return AppTheme.showLoadingSpinKit();
            }
          },
        ),
      ),
    );
  }

  Widget bodyWidget(List<BarcodeModel> modelList) {
    return Container(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.network(modelList[index].imageUrl!),
                  Container(
                    color: AppTheme.colorWhitC,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              modelList[0].itemArDescription!,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.textBoldStyle,
                            ),
                          ),
                          Container(
                            color: AppTheme.appBackgroundColor,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.price,
                                  style: AppTheme.titleOrangeTextStyle,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "${modelList[0].barcodePrice!.toStringAsFixed(3)}",
                                    style: AppTheme.titleOrangeTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              color: AppTheme.appBackgroundColor,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Strings.description,
                                    style: AppTheme.textBoldStyle,
                                  ),
                                  HtmlWidget(
                                    modelList[0].unitArDescription!,
                                    textStyle: AppTheme.titleTextStyle,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              color: AppTheme.colorWhitB,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Strings.notes,
                                    style: AppTheme.textBoldStyle,
                                  ),
                                  HtmlWidget(
                                    modelList[0].notes!,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
