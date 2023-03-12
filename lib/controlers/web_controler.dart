import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ppostman/components/app_snack_bar.dart';
import 'package:ppostman/repos/web_repo.dart';

class WebControler {
  final WebRepo _webRepo;

  WebControler(this._webRepo);

// variables
  dynamic _responseBody = "";
  int _responseStatusCode = 0;
  bool _isRequsetComplated = false;

// geters
  dynamic get responseBody => _responseBody;
  int get responseStatusCode => _responseStatusCode;
  bool get isRequsetComplated => _isRequsetComplated;

// get
  Future<void> sendGetRequest(
    String url, {
    String? header,
    BuildContext? context,
  }) async {
    _isRequsetComplated = false;
    Map<String, String>? head;
    try {
      if (header != "" && header != null) {
        head = {};
        (json.decode(header) as Map).forEach(
          (key, value) {
            head!.putIfAbsent(key.toString(), () => value.toString());
          },
        );
      }

      final response = await _webRepo.get(url: url, header: head);
      _responseBody = response.body;
      _responseStatusCode = response.statusCode;
    } catch (e) {
      if (context != null) {
        showAppSnackBar(context, "$e", color: Colors.teal);
      }
    }
    _isRequsetComplated = true;
  }

// post
  Future<void> sendPostRequest(
    String url, {
    required String header,
    required String body,
    BuildContext? context,
  }) async {
    _isRequsetComplated = false;
    Map<String, String> head = {};

    try {
      if (header != "") {
        (json.decode(header) as Map).forEach(
          (key, value) {
            head.putIfAbsent(key.toString(), () => value.toString());
          },
        );
      }
      Map? bodyToSend;
      try {
        bodyToSend = json.decode(body);
      } catch (e) {}

      final response =
          await _webRepo.post(url: url, header: head, body: bodyToSend ?? body);
      _responseStatusCode = response.statusCode;
      _responseBody = response.body;
    } catch (e) {
      if (context != null) {
        showAppSnackBar(context, "$e", color: Colors.teal);
      }
    }
    _isRequsetComplated = true;
  }

// put
  Future<void> sendPutRequest(
    String url, {
    required String header,
    required String body,
    BuildContext? context,
  }) async {
    _isRequsetComplated = false;
    Map<String, String> head = {};
    try {
      if (header != "") {
        (json.decode(header) as Map).forEach(
          (key, value) {
            head.putIfAbsent(key.toString(), () => value.toString());
          },
        );
      }
      Map? bodyToSend;
      try {
        bodyToSend = json.decode(body);
      } catch (e) {}
      final response =
          await _webRepo.put(url: url, header: head, body: bodyToSend ?? body);
      _responseBody = response.body;
      _responseStatusCode = response.statusCode;
    } catch (e) {
      if (context != null) {
        showAppSnackBar(context, "$e", color: Colors.teal);
      }
    }
    _isRequsetComplated = true;
  }
}
