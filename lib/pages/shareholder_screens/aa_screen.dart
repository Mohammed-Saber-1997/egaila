import 'package:flutter/material.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../../utils/strings.dart';
import '../../widgets/shareholder_item.dart';

class AAScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppTheme.buttonsColor,
          title: Text(
            Strings.shareholderActivities,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white70,
            indicatorWeight: 5.0,
            tabs: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'الانشطة السابقة',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'الانشطة الحالية',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // الانشطة السابقة
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => activityItem(Colors.red),
                  itemCount: 4,
                ),
              ),
            ),
            // الانشطة الحالية
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => activityItem(Colors.green),
                  itemCount: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget activityItem(Color color) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(color: flightBorderColor),
        ),
        child: Row(
          children: [
            Container(
              width: 7.0,
              height: 200.0,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'اسم النشاط : ',
                    style: AppTheme.subTitleTheme.copyWith(
                      fontSize: 2 * SizeConfig.textMultiplier,
                    ),
                  ),
                  Text(
                    'تاريخ بداية التسجيل : ',
                    style: AppTheme.subTitleTheme.copyWith(
                      fontSize: 2 * SizeConfig.textMultiplier,
                    ),
                  ),
                  Text(
                    'تاريخ نهاية التسجيل : ',
                    style: AppTheme.subTitleTheme.copyWith(
                      fontSize: 2 * SizeConfig.textMultiplier,
                    ),
                  ),
                  Text(
                    'الكمية : ',
                    style: AppTheme.subTitleTheme.copyWith(
                      fontSize: 2 * SizeConfig.textMultiplier,
                    ),
                  ),
                  Text(
                    'حالة النشاط : ',
                    style: AppTheme.subTitleTheme.copyWith(
                      fontSize: 2 * SizeConfig.textMultiplier,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
