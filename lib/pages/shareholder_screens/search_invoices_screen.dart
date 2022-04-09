import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eqaila_app/bloc/salesLocation/sales_location_bloc.dart';
import 'package:eqaila_app/bloc/shareholderPurchases/shareholder_purchases_bloc.dart';
import 'package:eqaila_app/bloc/shareholder_signin/shareholder_sign_in_bloc.dart';
import 'package:eqaila_app/models/models.dart';
import 'package:eqaila_app/repository/shareholder/shareholder_purchases_repository.dart';
import 'package:eqaila_app/utils/strings.dart';
import 'package:eqaila_app/widgets/app_button_widget.dart';
import 'package:eqaila_app/widgets/expand_card.dart';

import '../../AppTheme.dart';
import 'shareholder_purchases_screen.dart';

class SearchInvoicesScreen extends StatefulWidget {
  @override
  _SearchInvoicesScreenState createState() => _SearchInvoicesScreenState();
}

class _SearchInvoicesScreenState extends State<SearchInvoicesScreen> {
  DateTime? _dateTimeFrom, _dateTimeTo;

  final titleController = TextEditingController();

  var selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget() as PreferredSizeWidget?,
      body: BlocBuilder<SalesLocationBloc, SalesLocationState>(
        builder: (context, state) {
          if (state is LocationLoaded) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    expandedCard(
                      expandTitle: Strings.searchByInvoiceNumber,
                      widget: searchByInvoiceNumber(context),
                    ),
                    dividerWidget(),
                    expandedCard(
                      expandTitle: Strings.searchByDate,
                      widget: searchByDate(context),
                    ),
                    dividerWidget(),
                    expandedCard(
                      expandTitle: Strings.searchByLocation,
                      widget: searchByLocationWidget(state.modelLocation),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return AppTheme.showLoadingSpinKit();
          }
        },
      ),
    );
  }

  /// App Bar
  Widget appBarWidget() => AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          Strings.Search,
          style: AppTheme.appBarStyle,
        ),
      );

  /// Search By Date Widget
  Widget searchByDate(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 20),
              outLineButtonWidget(_dateTimeFrom, Strings.from, onPressed: () {
                {
                  showDatePicker(
                    context: context,
                    initialDate:
                        _dateTimeFrom == null ? DateTime.now() : _dateTimeFrom!,
                    builder: (BuildContext context, Widget? child) =>
                        AppTheme.datePickerTheme(child!),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                  ).then((date) {
                    setState(() {
                      _dateTimeFrom = date;
                      print(date.toString());
                    });
                  });
                }
              }),
              SizedBox(width: 20),
              outLineButtonWidget(_dateTimeTo, Strings.to, onPressed: () {
                {
                  showDatePicker(
                    context: context,
                    initialDate:
                        _dateTimeTo == null ? DateTime.now() : _dateTimeTo!,
                    builder: (BuildContext context, Widget? child) =>
                        AppTheme.datePickerTheme(child!),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                  ).then((date) {
                    setState(() {
                      _dateTimeTo = date;
                      print(date.toString());
                    });
                  });
                }
              }),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          AppButtonWidget(
            buttonText: Strings.Search,
            onButtonClicked: () => searchByDateEvent(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Search By Invoice Number Widget..
  Widget searchByInvoiceNumber(BuildContext context) {
    return Container(
      color: AppTheme.colorPrimaryB,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: TextField(
          textAlign: TextAlign.center,
          controller: titleController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            filled: true,
            fillColor: AppTheme.colorPrimaryB,
            prefixIcon: GestureDetector(
              child: icon(Icons.search),
              onTap: () => searchByInvoiceNumberEvent(),
            ),
            suffixIcon: IconButton(
                icon: icon(Icons.clear),
                onPressed: () {
                  titleController.text = '';
                }),
            hintText: Strings.invoiceNumber,
            hintStyle: AppTheme.textStyleGray16w600,
            border: AppTheme.border(),
            enabledBorder: AppTheme.border(),
            disabledBorder: AppTheme.border(),
            focusedErrorBorder: AppTheme.border(),
            focusedBorder: AppTheme.border(),
          ),
        ),
      ),
    );
  }

  /// Search By Location Widget
  Widget searchByLocationWidget(List<SalesLocationModel> modelLocation) {
    if (modelLocation == null) {
      return Text('No Location avelebole');
    } else {
      return Column(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(brightness: Brightness.light),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton(
                underline: Divider(color: Colors.transparent),
                icon: icon(Icons.expand_more),
                isExpanded: true,
                items: modelLocation
                    .map((item) => DropdownMenuItem(
                          child: Center(
                            child: Text(
                              item.locationName!,
                              style: AppTheme.textStyleDark16w600,
                            ),
                          ),
                          value: item.locationName,
                        ))
                    .toList(),
                onChanged: (dynamic selectedAccountType) {
                  print('$selectedAccountType');
                  setState(() {
                    selectedType = selectedAccountType;
                  });
                },
                value: selectedType,
                hint: Text(
                  Strings.chooseLocation,
                  style: AppTheme.textStyleDark16w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          AppButtonWidget(
              buttonText: Strings.Search,
              onButtonClicked: () => searchByLocationEvent()),
          SizedBox(height: 20),
        ],
      );
    }
  }

  /// outLine Button Widget used in Search By Date Widget
  Widget outLineButtonWidget(DateTime? dateTime, String text,
          {Function? onPressed}) =>
      Expanded(
        child: OutlineButton(
          onPressed: () => onPressed!(),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: icon(Icons.calendar_today),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    dateTime == null
                        ? text
                        : '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                    style: AppTheme.textStyleDark16w600,
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
          highlightedBorderColor: AppTheme.buttonsColor,
          color: AppTheme.buttonsColor,
          borderSide: BorderSide(color: AppTheme.buttonsColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      );

  /// Expanded Card Widget
  Widget expandedCard({required String expandTitle, Widget? widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: MyExpandCard(
            iconColor: AppTheme.textOrangeColor,
            backgroundColor: AppTheme.colorPrimaryB,
            title: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    expandTitle,
                    style: AppTheme.textStyleDark20w700,
                  ),
                ],
              ),
            ),
            children: <Widget>[
              Container(
                child: widget,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget icon(IconData icon) => Icon(
        icon,
        color: AppTheme.textOrangeColor,
      );

  Widget dividerWidget() => Divider(
        color: AppTheme.gg,
        height: 0.8,
      );

  /// Search By Invoice Number Event
  void searchByInvoiceNumberEvent() {
    // TODO: Implement [Search By Invoice Number] functionality.
  }

  /// Search By Location Event
  void searchByLocationEvent() {
    // TODO: Implement [Search By Location] functionality.
  }

  /// Search By Date Event
  void searchByDateEvent() {
    if (_dateTimeFrom != null) {
      final ShareholderSignInBloc user =
          BlocProvider.of<ShareholderSignInBloc>(context);
      if (user.state.model != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return BlocProvider<ShareholderPurchasesBloc>(
              create: (context) =>
                  ShareholderPurchasesBloc(ShareholderPurchasesRepositoryImpl())
                    ..add(GetPurchasesListByDate(
                      customerId: user.state.model!.shhMembershipId.toString(),
                      fromDate: _dateTimeFrom.toString(),
                      toDate: _dateTimeTo == null
                          ? DateTime.now().toString()
                          : _dateTimeTo.toString(),
                    )),
              child: ShareholderPurchasesScreen(),
            );
          }),
        );
      }
    }
  }
}
