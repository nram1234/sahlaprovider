import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sahlaprovider/scr/delivery_app/model/delivery_login_model.dart';

class AllDeliveryNetworking {
  Dio dio =
      new Dio(BaseOptions(baseUrl: "https://delivery.sahla-eg.com/api/auth"));
  Future<DileveryLoginModel> login({
    @required String phone,
    @required String password,
    @required String firebaseToken,
    @required String lang,
  }) async {
    FormData formData = new FormData.fromMap({
      "key": "1234567890",
      "password": password,
      "phone": phone,
      "firebase_token": firebaseToken,
      "lang": lang,
    });
    DileveryLoginModel data;
    await dio
        .post(
      '/login',
      data: formData,
    )
        .then((value) {
      data = DileveryLoginModel.fromJson(value.data);
      print(value.data);
    });

    return data;
  }

  Future<void> logout({
    @required String token,
  }) async {
    await dio
        .post('/logout', options: Options(headers: {"Authorization": token}))
        .then((value) {
      print(value.data);
    });
  }
}
