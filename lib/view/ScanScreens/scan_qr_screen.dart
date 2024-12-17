import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truck_pro/methods/navigate.dart';
import 'package:truck_pro/methods/show_customtoast.dart';
import 'package:truck_pro/view/Orders/order_details_controller.dart';
import 'package:truck_pro/view/Orders/order_details_driver.dart';
import '../../models/order_model.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/assets_manager.dart';
import '../../utilities/screen_sizes.dart';

class ScanDialogScreen extends StatefulWidget {
  final OrderModel orderModel;
  const ScanDialogScreen({
    super.key,
    required this.orderModel,
  });

  @override
  State<ScanDialogScreen> createState() => _ScanDialogScreenState();
}

class _ScanDialogScreenState extends State<ScanDialogScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [Expanded(child: scanQr(false))],
            ),
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      AssetsManager.scannerImage,
                      scale: 0.3,
                      height: screenHeight(context) * 0.5,
                      width: screenWidth(context) * 0.8,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight(context) * 0.04),
                    (cameraPermissionStatus.isGranted)
                        ? Text(
                            'Place QR Code Into The Square To Start Order Delivery!',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scanQr(bool isHiddenTreasure) {
    return FutureBuilder(
        future: requestCameraPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return buildQrScanner(context);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Camera Permission Is Required',
                      style: const TextStyle(color: AppColors.whiteColor),
                    ),
                    TextButton(
                      onPressed: () async {
                        Future.delayed(Duration.zero)
                            .then((value) => Navigator.of(context).pop());
                        openAppSettings();
                      },
                      child: Text('Open Settings',
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.primaryColor)),
                    ),
                  ],
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.whiteColor),
            );
          }
        });
  }

  buildQrScanner(BuildContext context) {
    return MobileScanner(
      controller: mobileScannerController,
      onDetect: (capture) {
        final Barcode barcode = capture.barcodes[0];
        debugPrint('Barcode found! ${barcode.rawValue}');
        (barcode.rawValue != null)
            ? (barcode.rawValue == widget.orderModel.orderId)
                ? pickOrder(context, widget.orderModel).then((v) =>
                    navigateReplace(context,
                        OrderDetailsDriver(orderModel: widget.orderModel)))
                : showFlutterToast(context,
                    message: 'Please scan the correct QR code!',
                    errorInfo: 'error')
            : null;
      },
      errorBuilder: (p0, p1, p2) {
        return Center(
          child: Text(
            // 'Error: ${p1.errorDetails!.message}',
            '',
          ),
        );
      },
    );
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (kDebugMode) {
      print('Camera permission status: ${status.toString()}');
    }
    cameraPermissionStatus = status;

    if (cameraPermissionStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> buildCameraPermissionDialogue(BuildContext context) {
    return Future.delayed(Duration.zero).then((value) => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: AppColors.whiteColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              title: Text('cameraPermission'),
              content: Text('cameraPermissionIsRequired'),
              actions: [
                TextButton(
                  onPressed: () async {
                    Future.delayed(Duration.zero)
                        .then((value) => Navigator.of(context).pop());
                  },
                  child: Text(
                    'close',
                    style: const TextStyle(
                        fontSize: 16, color: AppColors.blackColor),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Future.delayed(Duration.zero)
                        .then((value) => Navigator.of(context).pop());
                    openAppSettings();
                  },
                  child: Text('openSettings',
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.blackColor)),
                ),
              ],
            );
          },
        ));
  }
}
