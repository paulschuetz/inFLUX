import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:influx/utility/google_sheets/contact_data.dart';
import 'package:meta/meta.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart' show rootBundle;

class GoogleSheetsContactFormSaver{
  final String sheetId;
  SheetsApi _sheetsApi;

  GoogleSheetsContactFormSaver({ @required this.sheetId}) {
    if(sheetId == null || sheetId == "") throw new ArgumentError("sheetId can not be null or empty");
  }

  // grant autohorization from Google
  Future grantAuthorization() async{
    //var googleKey = File('./assets/influx2018-223815-0a1306d72d29.json');
    var googleKeyObject = json.decode(await rootBundle.loadString('assets/influx2018-223815-0a1306d72d29.json'));
    var serviceAccount = ServiceAccountCredentials.fromJson(googleKeyObject);
    var client = await clientViaServiceAccount(serviceAccount, ["https://www.googleapis.com/auth/spreadsheets"]);
    this._sheetsApi = SheetsApi(client);
  }

  Future saveContactForm(ContactData contact) async {

    var datetime = DateFormat("dd.MM.yyyy HH:mm:ss").format(DateTime.now().toUtc());
    ValueRange newDataRow = new ValueRange.fromJson({
      "values": [
        [ // fields A - D
          contact.name, contact.email, contact.phone, contact.issue, datetime
        ]
      ]
    });
    _sheetsApi.spreadsheets.values.append(newDataRow, this.sheetId, "Sheet1!A1:D1", valueInputOption: "USER_ENTERED");
  }
}