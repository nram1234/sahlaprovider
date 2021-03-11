import 'dart:io';
import 'package:sahlaprovider/utilitie/jsondata/Get_notification_details_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/agent_login_JSON.dart';
import 'package:sahlaprovider/utilitie/jsondata/buy_prescription_request_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/cancel_order_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/check_coupon_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/create_coupon_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/delete_pharamices_image_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/galler_jason.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_branches_JSON.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_category_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_order_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_products_cat_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_user_coupons_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_visitor_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_all_visitor_points_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_current_orders_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_home_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_list_notifications_JSON.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_list_reservation_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_list_weddings_services_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_waiting_orders_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_order_details_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/get_previous_orders_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/list_appointments_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/list_wedding_reservation_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/pharmacies_image_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_addproduct_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_doc_profile_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_branch_JSON.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_category_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_offer_JSON.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_edit_product_JSON.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_points_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_profile_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/preparation_wedding_service_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/ticket_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/tickets_json.dart';
import 'package:sahlaprovider/utilitie/jsondata/tickets_types_json.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AllNetworking {
  var paseurl = 'https://sahla-eg.com';

  //Response response;
  Dio dio = new Dio();

  Future<Agent_login_JSON> Login({
    @required String phone,
    @required String password,
    @required String firebase_token,
    @required String lang,
  }) async {
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "password": password,
      "phone": phone,
      "firebase_token": firebase_token,
      "lang": lang,
    });
    Agent_login_JSON data;
    await dio
        .post(
      paseurl + '/provider/agent_login',
      data: formData,
    )
        .then((value) {
      data = Agent_login_JSON.fromJson(value.data);
    });

    print(data);
    return data;
  }

  Future<http.Response> Get_all_products({
    @required String phone,
    @required String token_id,
    @required String limit,
    @required String page_number,
  }) async {
    http.Response response = await http.post(
      paseurl + '/provider/get_all_products',
      body: {
        "mode": "formdata",
        "key": "1234567890",
        "token_id": token_id,
        "limit": limit,
        "page_number": page_number,
      },
    );

    return response;
  }

  Future<http.Response> delete_product({
    @required String token_id,
    @required String product_id,
  }) async {
    http.Response response = await http.post(
      paseurl + '/provider/delete_product',
      body: {
        "mode": "formdata",
        "key": "1234567890",
        "token_id": token_id,
        "product_id": product_id,
      },
    );

    return response;
  }

  Future<Response> add_product(
      {@required String phone,
      @required String token_id,
      @required String title,
      @required String title_en,
      @required String current_price,
      @required String old_price,
      @required String description_ar,
      @required String description_en,
      @required String cat_id,
      @required File file}) async {
    Response response;
    String fileName = file.path.split('/').last;

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "cat_id": cat_id,
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "title_en": title_en,
      "current_price": current_price,

      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: new MediaType('image', 'png')),
    });
    response =
        await dio.post(paseurl + '/provider/add_product', data: formData);
    return response;
  }

  Future<Preparation_edit_product_JSON> preparation_edit_product({
    @required String token_id,
    @required int product_id,
  }) async {
    Preparation_edit_product_JSON data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_product": product_id,
    });

    await dio
        .post(
      paseurl + '/provider/preparation_edit_product',
      data: formData,
    )
        .then((value) {
      data = Preparation_edit_product_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_product({
    @required String token_id,
    @required String title,
    @required String title_en,
    @required String current_price,
    @required String old_price,
    @required String description_ar,
    @required String description_en,
    @required File file,
    @required int id_product,
    @required String cat_id,
  }) async {
    Response response;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "title_en": title_en,
      "current_price": current_price,
      "id_product": id_product,
      "cat_id": cat_id,
      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });
    response =
        await dio.post(paseurl + '/provider/edit_product', data: formData);
    return response;
  }

  Future<http.Response> get_offers({
    @required String token_id,
    @required String limit,
    @required String page_number,
  }) async {
    http.Response response = await http.post(
      paseurl + '/provider/get_offers',
      body: {
        "mode": "formdata",
        "key": "1234567890",
        "token_id": token_id,
        "limit": limit,
        "page_number": page_number,
      },
    );

    return response;
  }

  Future<Response> add_offer(
      {@required String phone,
      @required String token_id,
      @required String title,
      @required String title_en,
      @required String current_price,
      @required String old_price,
      @required String description_ar,
      @required String description_en,
      @required String end_date,
      @required String start_date,
      @required File file}) async {
    Response response;
    String fileName = file.path.split('/').last;

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "title_en": title_en,
      "current_price": current_price,

      "end_date": end_date,
      "start_date": start_date,

      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: new MediaType('image', 'png')),
    });
    response = await dio.post(paseurl + '/provider/add_offer', data: formData);
    return response;
  }

  Future<Response> delete_offers({
    @required String token_id,
    @required int product_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "offer_id": product_id,
    });
    response = await dio.post(
      paseurl + '/provider/delete_offers',
      data: formData,
    );

    return response;
  }

  Future<Preparation_edit_offer_JSON> preparation_edit_details({
    @required String token_id,
    @required int offer_id,
  }) async {
    Preparation_edit_offer_JSON data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "offer_id": offer_id,
    });

    await dio
        .post(
      paseurl + '/provider/preparation_edit_details',
      data: formData,
    )
        .then((value) {
      data = Preparation_edit_offer_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_offer({
    @required String token_id,
    @required String title,
    @required String title_en,
    @required String current_price,
    @required String old_price,
    @required String description_ar,
    @required String end_date,
    @required String start_date,
    @required String description_en,
    @required File file,
    @required int id_product,
  }) async {
    Response response;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "title_en": title_en,
      "current_price": current_price,
      "offer_id": id_product,

      "end_date": end_date,
      "start_date": start_date,

      "old_price": old_price,
      "description_ar": description_ar,
      "description_en": description_en,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });
    response = await dio.post(paseurl + '/provider/edit_offer', data: formData);
    return response;
  }

  Future<Get_all_branches_JSON> get_all_branches({
    @required String token_id,
  }) async {
    Get_all_branches_JSON data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/provider/get_all_branches',
      data: formData,
    )
        .then((value) {
      data = Get_all_branches_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> add_branch({
    @required String token_id,
    @required String title,
    @required String titlen_en,
    @required String phone,
    @required String whatsapp,
    @required String description,
    @required String description_en,
    @required String phone_second,
    @required String phone_third,
    @required String city_id,
    @required File file,
    @required String location,
    @required String address,
    @required String address_en,
    @required double lat,
    @required double lag,
  }) async {
    Response data;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "location": location,
      //==============
      "lat": lat,
      "lag": lag,
      //==============
      "address": address,
      "address_en": address_en,

      "title": title,
      "titlen_en": titlen_en,
      "phone": phone,
      "whatsapp": whatsapp,

      "description": description,
      "description_en": description_en,
      "phone_second": phone_second,
      "phone_third": phone_third,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
      "city_id": city_id,
    });

    await dio
        .post(
      paseurl + '/provider/add_branch',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Response> delete_branch({
    @required String token_id,
    @required int id_branch,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_branch": id_branch,
    });
    response = await dio.post(
      paseurl + '/provider/delete_branch',
      data: formData,
    );

    return response;
  }

  Future<Preparation_edit_branch_JSON> preparation_edit_branch({
    @required String token_id,
    @required int id_branch,
  }) async {
    Preparation_edit_branch_JSON data;
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_branch": id_branch,
    });
    response = await dio
        .post(
      paseurl + '/provider/preparation_edit_branch',
      data: formData,
    )
        .then((value) {
      data = Preparation_edit_branch_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_branch({
    @required int id_branch,
    @required String token_id,
    @required String title,
    @required String titlen_en,
    @required String phone,
    @required String whatsapp,
    @required String description,
    @required String description_en,
    @required String phone_second,
    @required String phone_third,
    @required File file,
    @required String location,
    @required String address,
    @required String address_en,
    @required double lat,
    @required double lag,
  }) async {
    Response data;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "location": location,
      //==============
      "lat": lat,
      "lag": lag,

      "id_branch": id_branch,
      "title": title,
      "titlen_en": titlen_en,
      "phone": phone,
      "whatsapp": whatsapp,

      "address_en": address_en,
      "address": address,

      "description": description,
      "description_en": description_en,
      "phone_second": phone_second,
      "phone_third": phone_third,
      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });

    await dio
        .post(
      paseurl + '/provider/edit_branch',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Get_list_notifications_JSON> get_list_notifications({
    @required String phone,
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_list_notifications_JSON data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_list_notifications',
      data: formData,
    )
        .then((value) {
      print('0000000000000000000000000000000000000000');
      print(value.data);
      data = Get_list_notifications_JSON.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_notification({
    @required String token_id,
    @required int id_notify,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_notify": id_notify,
    });
    response = await dio.post(
      paseurl + '/provider/delete_notification',
      data: formData,
    );

    return response;
  }

  Future<Tickets_json> tickets({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Tickets_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/tickets',
      data: formData,
    )
        .then((value) {
      data = Tickets_json.fromJson(value.data);
    });

    return data;
  }

  Future<Ticket_json> ticket({
    @required String token_id,
    @required int ticket_id,
  }) async {
    Ticket_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "ticket_id": ticket_id,
    });
    await dio
        .post(
      paseurl + '/provider/ticket',
      data: formData,
    )
        .then((value) {
      data = Ticket_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> new_ticket({
    @required String token_id,
    @required int ticket_type_id,
    @required String title,
    @required String content,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "ticket_type_id": ticket_type_id,
      "title": title,
      "content": content,
    });
    await dio
        .post(
      paseurl + '/provider/new_ticket',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Tickets_types_json> tickets_types({
    @required String token_id,
  }) async {
    Tickets_types_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/tickets_types',
      data: formData,
    )
        .then((value) {
      response = Tickets_types_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> new_reply({
    @required String token_id,
    @required int ticket_id,
    @required String content,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "ticket_id": ticket_id,
      "content": content,
    });
    response = await dio.post(
      paseurl + '/provider/new_reply',
      data: formData,
    );

    return response;
  }

  Future<Response> add_photography_requests({
    @required String token_id,
    @required String title,
    @required String content,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "content": content,
    });
    await dio
        .post(
      paseurl + '/provider/add_photography_requests',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Preparation_profile_json> preparation_profile({
    @required String token_id,
  }) async {
    Preparation_profile_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/preparation_profile',
      data: formData,
    )
        .then((value) {
      response = Preparation_profile_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> edit_profile({
    @required String token_id,
    @required String password,
    @required String name_ar,
    @required String name_en,
    @required String phone,
    @required String whatsapp,
    @required String floar_num,
    @required String description,
    @required String description_en,
    @required String phone_second,
    @required String phone_third,
    @required File main_img,
    @required String location,
//========================
    @required String instagram,
    @required String twitter,
    @required String facebook,
    @required String website,
    @required String email,
    @required String address,
    @required String addressEn,
    @required double lat,
    @required double lag,
  }) async {
    Response data;
    String fileName;
    if (main_img != null) {
      fileName = main_img.path.split('/').last;
    }
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "location": location,
      //==============
      "lat": lat,
      "lag": lag, "instagram": instagram, "twitter": twitter,
      "facebook": facebook,
      "website": website,
      "email": email,
      "name_ar": name_ar,
      "name_en": name_en,
      "phone": phone,
      "whatsapp": whatsapp,
      "address": address, "addressEn": addressEn,
      "floar_num": floar_num,
      "description": description,
      "description_en": description_en,
      "phone_second": phone_second,
      "password": password,
      "phone_third": phone_third,
      "main_img": main_img != null
          ? await MultipartFile.fromFile(main_img.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : null,
    });

    await dio
        .post(
      paseurl + '/provider/edit_profile',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Create_coupon_json> create_coupon({
    @required String token_id,
    @required int type,
  }) async {
    Create_coupon_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "type": type,
    });
    await dio
        .post(
      paseurl + '/provider/create_coupon',
      data: formData,
    )
        .then((value) {
      response = Create_coupon_json.fromJson(value.data);
    });

    return response;
  }

  Future<Get_home_json> get_home({
    @required String token_id,
    @required String lang,
  }) async {
    Get_home_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "lang": lang,
    });
    await dio
        .post(
      paseurl + '/provider/get_home',
      data: formData,
    )
        .then((value) {
      print('ggggggggggggggggggggggggggggggggggggggggggggggggg');
      print(value.data);
      print('ggggggggggggggggggggggggggggggggggggggggggggggggg');
      response = Get_home_json.fromJson(value.data);
    });

    return response;
  }

  Future<Get_list_gallery_json> get_list_gallery({
    @required String token_id,
  }) async {
    Get_list_gallery_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_list_gallery',
      data: formData,
    )
        .then((value) {
      response = Get_list_gallery_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> delete_image({
    @required String token_id,
    @required int img_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "img_id": img_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_image',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Response> add_img({
    @required String token_id,
    @required File file,
  }) async {
    Response response;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,

      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });
    response = await dio.post(paseurl + '/provider/add_img', data: formData);
    return response;
  }

  Future<Get_all_visitor_json> get_all_visitor({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_visitor_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_visitor',
      data: formData,
    )
        .then((value) {
      data = Get_all_visitor_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_visitor({
    @required String token_id,
    @required String visitor_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "visitor_id": visitor_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_visitor',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Get_all_users_visting_json> get_all_users_visting({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_users_visting_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_users_visting',
      data: formData,
    )
        .then((value) {
      data = Get_all_users_visting_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_all_user_coupons_json> get_all_user_coupons({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_user_coupons_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_user_coupons',
      data: formData,
    )
        .then((value) {
      data = Get_all_user_coupons_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_user_coupon({
    @required String token_id,
    @required String coupon_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "coupon_id": coupon_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_user_coupon',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Response> check_coupon({
    @required String token_id,
    @required String coupon,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "coupon": coupon,
    });
    await dio
        .post(
      paseurl + '/provider/check_coupon',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Preparation_points_json> preparation_points({
    @required String token_id,
  }) async {
    Preparation_points_json data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/preparation_points',
      data: formData,
    )
        .then((value) {
      data = Preparation_points_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_points({
    @required String token_id,
    @required String total_points,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "total_points": total_points,
    });
    await dio
        .post(
      paseurl + '/provider/edit_points',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Response> check_phone({
    @required String token_id,
    @required String coupon,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "coupon": coupon,
    });
    await dio
        .post(
      paseurl + '/provider/check_phone',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Response> logout({
    @required String token_id,
    @required String firebase_token,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "firebase_token": firebase_token,
    });
    await dio
        .post(
      paseurl + '/provider/logout',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Response> save_QR({
    @required String token_id,
    @required String file,
  }) async {
    Response response;
    String fileName = 'o';

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,

      "file": file
    });
    response = await dio.post(paseurl + '/provider/save_QR', data: formData);
    return response;
  }

  Future<Get_all_visitor_points_json> get_all_visitor_points({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_visitor_points_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_visitor_points',
      data: formData,
    )
        .then((value) {
      data = Get_all_visitor_points_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_points({
    @required String token_id,
    @required String visitor_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "visitor_id": visitor_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_points',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Response> empty_points({
    @required String total_points,
    @required String phone,
    @required String token_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "total_points": total_points,
      "phone": phone,
    });
    await dio
        .post(
      paseurl + '/provider/empty_points',
      data: formData,
    )
        .then((value) {
      response = value;
    });

    return response;
  }

  Future<Get_all_category_json> get_all_category({
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_category_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_category',
      data: formData,
    )
        .then((value) {
      data = Get_all_category_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> add_category(
      {@required String token_id,
      @required String title,
      @required String title_en,
      @required File file}) async {
    Response response;
    String fileName = file.path.split('/').last;

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "title_en": title_en,

      "file": await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: new MediaType('image', 'png')),
    });
    response =
        await dio.post(paseurl + '/provider/add_category', data: formData);
    return response;
  }

  Future<Response> delete_category({
    @required String token_id,
    @required String cat_id,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "cat_id": cat_id,
    });
    response = await dio.post(
      paseurl + '/provider/delete_category',
      data: formData,
    );

    return response;
  }

  Future<Preparation_edit_category_json> preparation_edit_category({
    @required String token_id,
    @required String cat_id,
  }) async {
    Preparation_edit_category_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "cat_id": cat_id,
    });

    await dio
        .post(
      paseurl + '/provider/preparation_edit_category',
      data: formData,
    )
        .then((value) {
      data = Preparation_edit_category_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_category({
    @required String token_id,
    @required String title,
    @required String title_en,
    @required File file,
    @required String cat_id,
  }) async {
    Response response;
    String fileName;
    if (file != null) {
      fileName = file.path.split('/').last;
    }

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "title_en": title_en,

      "cat_id": cat_id,

      "file": file != null
          ? await MultipartFile.fromFile(file.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : ' ',
    });
    response =
        await dio.post(paseurl + '/provider/edit_category', data: formData);
    return response;
  }

  Future<Preparation_addproduct_json> preparation_addproduct({
    @required String token_id,
  }) async {
    Preparation_addproduct_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/preparation_addproduct',
      data: formData,
    )
        .then((value) {
      data = Preparation_addproduct_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_all_products_cat_json> get_all_products_cat({
    @required String cat_id,
    @required String token_id,
    @required int limit,
    @required int page_number,
  }) async {
    Get_all_products_cat_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "cat_id": cat_id,
      "limit": limit,
      "page_number": page_number,
    });
    await dio
        .post(
      paseurl + '/provider/get_all_products_cat',
      data: formData,
    )
        .then((value) {
      data = Get_all_products_cat_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_Waiting_Orders_json> get_waiting_orders({
    @required String token_id,
  }) async {
    Get_Waiting_Orders_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_waiting_orders',
      data: formData,
    )
        .then((value) {
      data = Get_Waiting_Orders_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_order_details_json> get_order_details({
    @required int id_order,
    @required String token_id,
  }) async {
    Get_order_details_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "id_order": id_order,
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_order_details',
      data: formData,
    )
        .then((value) {
      data = Get_order_details_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Cancel_order_json> delete_order({
    @required String token_id,
    @required int order_id,
  }) async {
    Cancel_order_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_order": order_id,
    });
    await dio
        .post(
      paseurl + '/provider/delete_order',
      data: formData,
    )
        .then((value) {
      data = Cancel_order_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_previous_orders_json> get_previous_orders({
    @required String token_id,
  }) async {
    Get_previous_orders_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_previous_orders',
      data: formData,
    )
        .then((value) {
      data = Get_previous_orders_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Get_current_orders_json> get_current_orders({
    @required String token_id,
  }) async {
    Get_current_orders_json data;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/provider/get_current_orders',
      data: formData,
    )
        .then((value) {
      data = Get_current_orders_json.fromJson(value.data);
    });
    //  print(data.result.contactInfo[0].);
    return data;
  }

  Future<Response> update_order({
    @required String token_id,
    @required String id_order,
    @required int key_action,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_order": id_order,
      "key_action": key_action,
    });
    await dio
        .post(
      paseurl + '/provider/update_order',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Pharmacies_image_json> pharmacies_image({
    @required String token_id,
  }) async {
    Pharmacies_image_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/medicine/pharmacies_image',
      data: formData,
    )
        .then((value) {
      data = Pharmacies_image_json.fromJson(value.data);
    });

    return data;
  }

  Future<Delete_pharamices_image_json> delete_pharamices_image({
    @required String token_id,
    @required String id_request,
  }) async {
    Delete_pharamices_image_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_request": id_request,
    });

    await dio
        .post(
      paseurl + '/medicine/delete_pharamices_image',
      data: formData,
    )
        .then((value) {
      data = Delete_pharamices_image_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> add_replay({
    @required String token_id,
    @required String id_request,
    @required String price,
    @required String message,
  }) async {
    Response data;

    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_request": id_request,
      "price": price,
      "message": message,
    });
    await dio
        .post(
      paseurl + '/medicine/add_replay',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Buy_prescription_request_json> buy_prescription_request({
    @required String token_id,
  }) async {
    Buy_prescription_request_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/medicine/buy_prescription_request',
      data: formData,
    )
        .then((value) {
      data = Buy_prescription_request_json.fromJson(value.data);
    });

    return data;
  }

//000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
//   Future<Buy_prescription_request_json> buy_prescription_request({
//     @required String token_id,
//
//   }) async {
//     Buy_prescription_request_json data;
//     FormData formData = new FormData.fromMap({
//       // "mode": "formdata",
//       "key": "1234567890",
//       "token_id": token_id,
//
//     });
//
//     await dio
//         .post(
//       paseurl + '/medicine/buy_prescription_request',
//       data: formData,
//     )
//         .then((value) {
//       data = Buy_prescription_request_json.fromJson(value.data);
//     });
//
//     return data;
//   }
//

  Future<Preparation_doc_profile_json> preparation_doc_profile({
    @required String token_id,
  }) async {
    Preparation_doc_profile_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/medicine/preparation_profile',
      data: formData,
    )
        .then((value) {
      response = Preparation_doc_profile_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> edit_doc_profile({
    @required String token_id,
    @required String password,
    @required String name_ar,
    @required String name_en,
    @required String phone,
    @required String whatsapp,
    @required String floar_num,
    @required String description,
    @required String description_en,
    @required String phone_second,
    @required String phone_third,
    @required File main_img,
    @required String location,
//========================
    @required String instagram,
    @required String twitter,
    @required String facebook,
    @required String website,
    @required String email,
    @required String address,
    @required String addressEn,
    @required double lat,
    @required double lag,
    @required String detection_price,
    @required String detection_price_en,
    @required String waiting_time,
    @required String specialization,
    @required String waiting_time_en,
    @required String specialization_en,
  }) async {
    Response data;
    String fileName;
    if (main_img != null) {
      fileName = main_img.path.split('/').last;
    }
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "location": location,
      //==============
      "lat": lat,
      "lag": lag, "instagram": instagram, "twitter": twitter,
      "facebook": facebook,
      "website": website,
      "email": email,
      "name_ar": name_ar,
      "name_en": name_en,
      "phone": phone,
      "whatsapp": whatsapp,
      "address": address, "addressEn": addressEn,
      "floar_num": floar_num,
      "description": description,
      "description_en": description_en,
      "phone_second": phone_second,
      "password": password,
      "phone_third": phone_third,

      "detection_price": detection_price,
      "detection_price_en": detection_price_en,
      "waiting_time": waiting_time,
      "waiting_time_en": waiting_time_en,
      "specialization": specialization,
      "specialization_en": specialization_en,

      "main_img": main_img != null
          ? await MultipartFile.fromFile(main_img.path,
              filename: fileName, contentType: new MediaType('image', 'png'))
          : null,
    });

    await dio
        .post(
      paseurl + '/medicine/edit_profile',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<List_appointments_json> list_appointments({
    @required String token_id,
  }) async {
    List_appointments_json response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });
    await dio
        .post(
      paseurl + '/medicine/list_appointments',
      data: formData,
    )
        .then((value) {
      response = List_appointments_json.fromJson(value.data);
    });

    return response;
  }

  Future<Response> add_appointment({
    @required String token_id,
    @required String name,
    @required String name_en,
    @required String from_hrs,
    @required String from_hrs_en,
    @required String to_hrs,
    @required String to_hrs_en,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "name": name,
      "name_en": name_en,
      "from_hrs": from_hrs,
      "from_hrs_en": from_hrs_en,
      "to_hrs": to_hrs,
      "to_hrs_en": to_hrs_en,
    });
    response = await dio.post(
      paseurl + '/medicine/add_appointment',
      data: formData,
    );

    return response;
  }

  Future<Get_list_reservation_json> get_list_reservation({
    @required String token_id,
  }) async {
    Get_list_reservation_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/medicine/get_list_reservation',
      data: formData,
    )
        .then((value) {
      data = Get_list_reservation_json.fromJson(value.data);
    });

    return data;
  }

  Future<Get_List_wedding_reservation_json> get_List_wedding_reservation({
    @required String token_id,
  }) async {
    Get_List_wedding_reservation_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/medicine/list_wedding_reservation',
      data: formData,
    )
        .then((value) {
      data = Get_List_wedding_reservation_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_ticket({
    @required String token_id,
    @required int id_ticket,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_ticket": id_ticket,
    });
    response = await dio.post(
      paseurl + '/provider/delete_ticket',
      data: formData,
    );

    return response;
  }

  Future<Get_notification_details_json> get_notification_details({
    @required String token_id,
    @required int id_notify,
  }) async {
    Get_notification_details_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id, "id_notify": id_notify,
    });

    await dio
        .post(
      paseurl + '/provider/get_notification_details',
      data: formData,
    )
        .then((value) {
      print('0000000000000000000000000000000000000000');
      print(value.data);
      data = Get_notification_details_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_list_reservation({
    @required String token_id,
    @required int id_list,
  }) async {
    Response data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_list": id_list,
    });

    await dio
        .post(
      paseurl + '/medicine/delete_list_reservation',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Response> accepted_list_reservation({
    @required String token_id,
    @required int id_list,
  }) async {
    Response data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_list": id_list,
    });

    await dio
        .post(
      paseurl + '/medicine/accepted_list_reservation',
      data: formData,
    )
        .then((value) {
      data = value;
    });

    return data;
  }

  Future<Get_list_weddings_services_json> get_list_weddings_services({
    @required String token_id,
  }) async {
    Get_list_weddings_services_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/weddings/list_weddings_services',
      data: formData,
    )
        .then((value) {
      data = Get_list_weddings_services_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> delete_wedding_service({
    @required String token_id,
    @required String id_list,
  }) async {
    Response response;
    FormData formData = new FormData.fromMap({
      "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "id_list": id_list,
    });
    response = await dio.post(
      paseurl + '/weddings/delete_wedding_service',
      data: formData,
    );

    return response;
  }

  Future<Response> add__wedding_service({
    @required String token_id,
    @required String name,
    @required String name_en,
    @required String price,
    @required int currency_id,
  }) async {
    Response response;

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "name": name,
      "name_en": name_en,
      "currency_id": currency_id, "price": price,
    });
    response = await dio.post(paseurl + '/weddings/add_wedding_service',
        data: formData);
    return response;
  }

  Future<Preparation_wedding_service_json> Preparation_wedding_service({
    @required String token_id,
  }) async {
    Preparation_wedding_service_json data;
    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
    });

    await dio
        .post(
      paseurl + '/weddings/preparation_wedding_service',
      data: formData,
    )
        .then((value) {
      print(value.data);
      data = Preparation_wedding_service_json.fromJson(value.data);
    });

    return data;
  }

  Future<Response> edit_wedding_service({
    @required String token_id,
    @required String name,
    @required String name_en,
    @required String price,
    @required int currency_id,  @required String id_list
  }) async {
    Response response;

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "name": name,
      "name_en": name_en,
      "currency_id": currency_id, "price": price, "id_list": id_list,
    });
    response = await dio.post(paseurl + '/weddings/edit_wedding_service',
        data: formData);
    return response;
  }


  Future<Response> sending_notifaction({
    @required String token_id,
    @required String title,
    @required String content,
    @required String id_user,
    @required int key_type,
  }) async {
    Response response;

    FormData formData = new FormData.fromMap({
      // "mode": "formdata",
      "key": "1234567890",
      "token_id": token_id,
      "title": title,
      "content": content,
      "id_user": id_user, "key_type": key_type,
    });
    response = await dio.post(paseurl + '/provider/sending_notifaction',
        data: formData);
    return response;
  }
}
