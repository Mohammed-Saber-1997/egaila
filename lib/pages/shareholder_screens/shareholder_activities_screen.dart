import 'package:flutter/material.dart';

import '../../AppTheme.dart';
import '../../utils/strings.dart';

class ShareholderActivitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: AppTheme.appBackgroundColor,
        ),
        backgroundColor: AppTheme.buttonsColor,
        title: Text(
          // 'أنشطة المساهم',
          Strings.shareholderActivities,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: <Widget>[
              shareholderActivityItem(context),
              Expanded(
                child: shareholderSubActivityItem(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget shareholderActivityItem(BuildContext context) => Container(
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () => print('النشاط ${index + 1}'),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'النشاط  ${index + 1}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.subTitleTheme.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: 4,
        ),
      ),
    );

Widget shareholderSubActivityItem(BuildContext context) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(color: AppTheme.buttonsColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: GridView.count(
              crossAxisCount: 1,
              mainAxisSpacing: 5,
              // crossAxisSpacing: 5,
              childAspectRatio: (3 / 1),
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () => print('النشاط الفرعي ${index + 1}'),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.buttonsColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'النشاط الفرعي  ${index + 1}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.subTitleTheme.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

Widget horizontalDividerWidget(BuildContext context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 2.0,
      width: MediaQuery.of(context).size.width,
      child: Divider(color: AppTheme.gg),
    );

Widget verticalDividerWidget(BuildContext context,
        {EdgeInsetsGeometry? padding}) =>
    Container(
      padding: padding,
      height: MediaQuery.of(context).size.width * 0.4,
      width: 2.0,
      child: VerticalDivider(color: AppTheme.gg),
    );
