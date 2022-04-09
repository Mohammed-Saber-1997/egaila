import 'package:flutter/material.dart';

import 'AppTheme.dart';

const String BASE_URL = 'https://www.egailacoop.com';
// const String BASE_URL_B = "https://intapi.cooopnet.com/api/v1";
const String BASE_URL_B = "https://api.egailacoop.com/api/v1";
//const String BASE_URL_TWO = 'https://intapi.cooopnet.com/api/v1';
// const String root = "https://api.cooopnet.com/api";
const String root = "https://api.egailacoop.com/api";

const String KEY_API = 'ApiKey';
const String API_KEY =
    'AIzaSyBWAv_ZEngtvHSGmWuTpQXbAnCll3d7Dqg_9d65044920984d1e-a5f4056614195f46';

const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppTheme.buttonsColor, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppTheme.buttonsColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
