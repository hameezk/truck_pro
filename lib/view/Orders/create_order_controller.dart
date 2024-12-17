import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truck_pro/methods/loading_dialog.dart';
import 'package:truck_pro/methods/show_customtoast.dart';
import 'package:truck_pro/models/order_model.dart';
import 'package:truck_pro/models/user_model.dart';
import 'package:uuid/uuid.dart';

import '../../data/network/parse_response.dart';
import '../../models/receipt_model.dart';

TextEditingController pickupLocation = TextEditingController();
TextEditingController deliveryLocation = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phonenoController = TextEditingController();
TextEditingController nameController = TextEditingController();
String ocrReceiptParserEndPoint =
    'https://api.edenai.run/v2/ocr/financial_parser';
String edenAiApiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiYjBhMWVmOWEtYmI3MS00YTViLTgwNzUtZDNhZWU1YTcyZTIxIiwidHlwZSI6ImFwaV90b2tlbiJ9.QAnMZyFoIO9rHtG3p7-wsxPh_pTqd7b2I4FsHCbXS9g';
String? pickuplatitude;
String? pickupLongitude;
String? deliverylatitude;
String? deliveryLongitude;
List<Marker> marker = <Marker>[];
List<Map<String, dynamic>> ordersList = [];
String ocrError = '';
ReceiptModel? receiptModel;

initOrder() async {
  emailController.text = UserModel.loggedinUser!.email ?? '';
  nameController.text = UserModel.loggedinUser!.name ?? '';
  phonenoController.text = UserModel.loggedinUser!.phoneno ?? '';
  pickupLocation.clear();
  deliveryLocation.clear();
  pickuplatitude = null;
  pickupLongitude = null;
  deliverylatitude = null;
  deliveryLongitude = null;
}

/// Get Pickup Address From Lat Long
///
Future<void> getPickupAddressFromLatLong(LatLng position, setState) async {
  String apiKey = 'AIzaSyDqK0KSEnFJsJJ_X7IGDIZMH_Yegicgz08';
  String url =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey&language=en';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    if (data['results'].isNotEmpty) {
      var result = data['results'][0];
      var address = result['formatted_address'];
      // Helper function to extract components
      String? getAddressComponent(List components, String type) {
        return components.firstWhere(
          (c) => (c['types'] as List).contains(type),
          orElse: () => null,
        )?['long_name'];
      }

      var postalCode =
          getAddressComponent(result['address_components'], 'postal_code');
      var city = getAddressComponent(result['address_components'], 'locality');
      var country =
          getAddressComponent(result['address_components'], 'country');
      var streetAddress =
          getAddressComponent(result['address_components'], 'route');

      debugPrint('Full Address: $address');
      debugPrint('Postal Code: ${postalCode ?? 'Not found'}');
      debugPrint('City: ${city ?? 'Not found'}');
      debugPrint('Country: ${country ?? 'Not found'}');
      debugPrint('Street Address: ${streetAddress ?? 'Not found'}');
      pickupLocation.text = address;
      pickupLongitude = position.longitude.toString();
      pickuplatitude = position.latitude.toString();

      await setmarker(position.latitude, position.longitude);
      setState(() {});
    }
  } else {
    debugPrint('Failed to fetch address');
  }
}

/// Get Deeliveery Address From Lat Long
///
Future<void> getDeliveryAddressFromLatLong(position, setState) async {
  String apiKey = 'AIzaSyDqK0KSEnFJsJJ_X7IGDIZMH_Yegicgz08';
  String url =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey&language=en';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    if (data['results'].isNotEmpty) {
      var result = data['results'][0];
      var address = result['formatted_address'];
      // Helper function to extract components
      String? getAddressComponent(List components, String type) {
        return components.firstWhere(
          (c) => (c['types'] as List).contains(type),
          orElse: () => null,
        )?['long_name'];
      }

      var postalCode =
          getAddressComponent(result['address_components'], 'postal_code');
      var city = getAddressComponent(result['address_components'], 'locality');
      var country =
          getAddressComponent(result['address_components'], 'country');
      var streetAddress =
          getAddressComponent(result['address_components'], 'route');

      debugPrint('Full Address: $address');
      debugPrint('Postal Code: ${postalCode ?? 'Not found'}');
      debugPrint('City: ${city ?? 'Not found'}');
      debugPrint('Country: ${country ?? 'Not found'}');
      debugPrint('Street Address: ${streetAddress ?? 'Not found'}');
      deliveryLocation.text = address;
      deliveryLongitude = position.longitude.toString();
      deliverylatitude = position.latitude.toString();

      await setmarker(position.latitude, position.longitude);
      setState(() {});
    }
  } else {
    debugPrint('Failed to fetch address');
  }
}

/// Set Marker
Future<Position> setmarker(double lat, double long) {
  marker.add(
    Marker(
      markerId: const MarkerId('2'),
      position: LatLng(lat, long),
      infoWindow: const InfoWindow(title: 'My current location'),
    ),
  );
  return Geolocator.getCurrentPosition();
}

/// Get current address
Future<Position?> getUserCurrentLocation() async {
  await Geolocator.requestPermission()
      .then((value) {})
      .onError((error, stackTrace) {});
  LocationPermission status = await Geolocator.checkPermission();
  if (status == LocationPermission.deniedForever ||
      status == LocationPermission.denied) {
    return null;
  }
  if (status == LocationPermission.whileInUse ||
      status == LocationPermission.always) {
    return Geolocator.getCurrentPosition();
  }
  return null;
}

Future<void> getImageFromCamera(
    BuildContext bottomNavContext, bool mounted, Function setState) async {
  print('edge detection starts .... 1');
  bool isCameraGranted = await Permission.camera.request().isGranted;
  if (!isCameraGranted) {
    isCameraGranted =
        await Permission.camera.request() == PermissionStatus.granted;
  }

  print('edge detection starts .... 2');

  if (!isCameraGranted) {
    // Have not permission to camera
    return;
  }

  print('edge detection starts .... 3');

  // Generate filepath for saving
  String imagePath = join((await getApplicationSupportDirectory()).path,
      "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

  print('edge detection starts .... 4');

  bool success = false;

  try {
    print('edge detection starts .... 5');

    //Make sure to await the call to detectEdge.
    success = await EdgeDetection.detectEdge(
      imagePath,
      canUseGallery: true,
      androidScanTitle: 'Scanning', // use custom localizations for android
      androidCropTitle: 'Crop',
      androidCropBlackWhiteTitle: 'Black White',
      androidCropReset: 'Reset',
    );
    print('edge detection starts .... 6');

    if (kDebugMode) {
      print("success: $success");
    }
  } catch (e) {
    if (kDebugMode) {
      print('error in edge detection ${e.toString()}');
    }
  }

  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  if (!mounted) return;

  Map<String, dynamic> dataMap = {
    "response_as_dict": true,
    "attributes_as_list": false,
    "show_base_64": true,
    "show_original_response": false,
    "document_type": "receipt",
    "convert_to_pdf": false,
    "providers": "amazon",
    "language": "en",
    "file": await MultipartFile.fromFile(
      imagePath,
    ),
  };
  print('edge detection starts .... 7');

  FormData data = FormData.fromMap(dataMap);

  if (success) {
    imagePath;
    parseReceipt(
      bottomNavContext,
      data,
      setState,
    );
    print('edge detection starts .... 8');
  }
}

Future<bool> parseReceipt(
    BuildContext context, FormData requestData, Function setState) async {
  try {
    showLoadingDialog(context, 'Parsing Receipt...');
    if (kDebugMode) {
      print('EdenAi OCR Api url: $ocrReceiptParserEndPoint');
      print('OCR Api queryParameters: $requestData');
    }
    Map<String, dynamic>? headers;
    headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $edenAiApiKey',
    };
    Dio dio = Dio();

    Response responce = await dio
        .post(
          ocrReceiptParserEndPoint,
          data: requestData,
          options: Options(
            headers: headers,
          ),
        )
        .timeout(const Duration(seconds: 40));
    if (kDebugMode) {
      print('Ocr Response Code : ${responce.statusCode}');
      print(
          "Ladies and gentelmen, Here's the Ocr response to parse: $responce");
    }

    if (responce.statusCode == 200) {
      Map<String, dynamic> responceJson = returnResponce(responce);
      receiptModel = ReceiptModel.fromJson(responceJson['amazon']);
      Navigator.pop(context);
      // createOrderWithReceipt(context, receiptModel!.receiptProducts);
      for (var item in receiptModel!.receiptProducts!) {
        ordersList.add(
          {
            'name': item.productName,
            'qty': item.productQty,
            'price': item.productPrice,
          },
        );
      }
      setState(() {});
    } else {
      if (kDebugMode) {
        print('error: ${responce.statusCode} ');
      }
      Navigator.pop(context);
      showFlutterToast(
        context,
        errorInfo: 'error',
        message: 'An error occoured while parsing the receipt',
      );
    }
    return true;
  } on DioException catch (e) {
    if (kDebugMode) {
      print('Ocr Response code: ${e.response!.statusCode.toString()}');
      print('Ocr Error: ${e.response.toString()}');
    }
    // ocrError = e.response!.data['message'].toString();
    Navigator.pop(context);
    return false;
  } catch (error) {
    if (kDebugMode) {
      print("Some Error Ocr: $error");
    }
    Navigator.pop(context);
    return false;
  }
}

void deleteOrderItem(int index) {}

void checkValues(BuildContext context) {
  if (pickupLongitude == null ||
      pickupLongitude == '' ||
      pickuplatitude == null ||
      pickuplatitude == '' ||
      pickupLocation.text.isEmpty ||
      deliveryLongitude == null ||
      deliveryLongitude == '' ||
      deliverylatitude == null ||
      deliverylatitude == '' ||
      deliveryLocation.text.isEmpty) {
    showFlutterToast(context,
        message: "Please select pickup and delivery locations!",
        errorInfo: 'error');
  } else if (ordersList.isEmpty) {
    showFlutterToast(context,
        message: "Please add some items to Order!", errorInfo: 'error');
  } else {
    cerateOrder(context);
  }
}

void cerateOrder(BuildContext context) async {
  showLoadingDialog(context, 'Creating Order...');
  Uuid uuid = Uuid();
  try {
    OrderModel orderModel = OrderModel(
      orderId: uuid.v1(),
      userId: UserModel.loggedinUser!.id,
      driverId: null,
      pickupLocation: pickupLocation.text,
      deliveryLocation: deliveryLocation.text,
      pickupLongitude: pickupLongitude,
      pickuplatitude: pickuplatitude,
      deliveryLongitude: deliveryLongitude,
      deliverylatitude: deliverylatitude,
      createdAt: DateTime.now().toString(),
      deliveredAt: null,
      isAccepted: false,
      isActive: true,
      isDelivered: false,
      orderItems: ordersList,
      status: 'active',
      trackingStatus: 'Placed',
      isPicked: false,
      deliveryRemarks: null,
      deliveryProof: null,
    );
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderModel.orderId)
        .set(orderModel.toMap())
        .then(
      (value) {
        Navigator.pop(context);
        showFlutterToast(context,
            message: 'New Order created!', errorInfo: 'success');

        Navigator.pop(context);
      },
    );
  } on FirebaseException catch (e) {
    showFlutterToast(context, message: e.toString(), errorInfo: 'error');
  } catch (e) {
    showFlutterToast(context,
        message: 'An error occoured!', errorInfo: 'error');
  }
}
