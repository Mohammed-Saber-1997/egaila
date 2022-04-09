import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:eqaila_app/bloc/scanner_search/search_scanner_bloc.dart';
import 'package:eqaila_app/repository/barcode_details_repository.dart';
import 'package:eqaila_app/utils/images.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/tooltip_shapeborder.dart';

import '../AppTheme.dart';
import 'barcode_details_page.dart';

class ScreenScannerPage extends StatefulWidget {
  static const routeName = 'Barcode_Search';

  @override
  _ScreenScannerPageState createState() => _ScreenScannerPageState();
}

class _ScreenScannerPageState extends State<ScreenScannerPage> {
  String qrCodeResult = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            Strings.barcodeSearch,
            style: AppTheme.textStyleWhite20w600
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                headerWidget(context),
                bodyWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Header Widget
  /// [Search Field && back icon && Text description]
  Widget headerWidget(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 24, right: 16, left: 16),
        decoration: ShapeDecoration(
          color: AppTheme.buttonsColor,
          shape: TooltipShapeBorder(
            arrowHeight: 30,
            arrowWidth: 60,
            //radius: 0.0,
            arrowArc: 0.1,
          ),
          shadows: AppTheme.shadows,
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      Strings.barcodeSearch,
                      textAlign: TextAlign.center,
                      style: AppTheme.textStyleWhite20w600,
                    ),
                  ),
                  searchField(),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        Strings.barcodeDescriptionText,
                        style: AppTheme.textStyleWhiteB16w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Body Widget
  Widget bodyWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () async {
              scanBarcodeNormal(context);
            },
            child: SvgPicture.asset(
              Images.ic_barcode,
              color: AppTheme.textOrangeColor,
              width: 200,
              height: 200,
            ),
          ),
          Text(
            "Result",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            qrCodeResult,
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Search Field Widget..
  Widget searchField() => Padding(
        padding: EdgeInsets.all(20.0),
        child: TextField(
          textAlign: TextAlign.center,
          controller: titleController,
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => submitData(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14.0),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: GestureDetector(
              onTap: () => submitData(),
              child: Icon(Icons.search, color: AppTheme.colorPrimary),
            ),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: AppTheme.colorPrimary,
                ),
                onPressed: () {
                  titleController.text = '';
                }),
            hintText: Strings.searchProducts,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.secondary, width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.secondary, width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppTheme.secondary, width: 1.4),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      );

  /// submit Data Event
  void submitData() {
    setState(() {
      qrCodeResult = titleController.text;
    });
    if (qrCodeResult.isNotEmpty) {
      navigateToBarcodeDetails();
    } else {
      _scaffoldKey.currentState!.showSnackBar(
        showSnackBarM(Strings.barcodeFieldEmpty) as SnackBar,
      );
    }
  }

  /// show SnackBar
  Widget showSnackBarM(String text) => SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(color: AppTheme.lightGrey, fontSize: 16),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: AppTheme.black,
      );

  Future<void> scanBarcodeNormal(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      if (barcodeScanRes != '' &&
          barcodeScanRes.isNotEmpty &&
          barcodeScanRes != '-1') {
        AssetsAudioPlayer.newPlayer().open(
          Audio(Images.s_scanner),
        );
        navigateToBarcodeDetails();
      }
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      qrCodeResult = barcodeScanRes;
    });
  }

  /// navigate To BarcodeDetails
  void navigateToBarcodeDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SearchScannerBloc>(
          create: (context) => SearchScannerBloc(BarcodeDetailsRepositoryImpl())
            ..add(BarcodeDetails(qrCodeResult)),
          child: BarcodeDetailsPage(),
        );
      }),
    );
  }
}
