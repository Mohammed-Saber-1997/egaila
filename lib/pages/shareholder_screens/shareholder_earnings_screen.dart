import 'package:flutter/material.dart';

import '../../AppTheme.dart';

class ShareholderEarningsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: AppTheme.appBackgroundColor,
          ),
          backgroundColor: AppTheme.buttonsColor,
          title: Text(
            'أرباح المساهم',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            //headerWidget(context),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return _buildItem(context);
                },
                itemCount: 10,
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '2019/2020',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '8000.247 د ك',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
