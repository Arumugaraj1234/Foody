import 'package:flutter/cupertino.dart';

class NetworkResponse {
  int responseCode;
  String responseMessage;
  dynamic responseData;

  NetworkResponse(
      {@required this.responseCode,
      @required this.responseMessage,
      @required this.responseData});
}
