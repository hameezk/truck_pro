// ignore_for_file: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:truck_pro/utilities/app_colors.dart';
import 'create_order_controller.dart';

class GoogleMapWidget extends StatefulWidget {
  final bool isPickup;
  final Function createOrderState;
  const GoogleMapWidget({
    Key? key,
    required this.isPickup,
    required this.createOrderState,
  }) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

String? address;
String? country;
String? city;
String? latitude;
String? longitude;
String? zipcode;

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final Completer<GoogleMapController> googleMapController = Completer();
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(33.6844, 73.0479), zoom: 14);

  @override
  initState() {
    marker = <Marker>[];
    getUserCurrentLocation().then((position) {
      setState(() {
        cameraPosition = CameraPosition(
            zoom: 14, target: LatLng(position!.latitude, position.longitude));
        setmarker(position.latitude, position.longitude);
      });
    });
    marker = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
                onTap: (latLng) {
                  (widget.isPickup)
                      ? getPickupAddressFromLatLong(latLng, setState)
                          .then((value) {
                          setState(() {
                            setmarker(latLng.latitude, latLng.longitude);
                          });
                        })
                      : getDeliveryAddressFromLatLong(latLng, setState)
                          .then((value) {
                          setState(() {
                            setmarker(latLng.latitude, latLng.longitude);
                          });
                        });
                  if (kDebugMode) {
                    print('${latLng.latitude}, ${latLng.longitude}');
                  }
                },
                myLocationButtonEnabled: true,
                initialCameraPosition: cameraPosition,
                markers: Set<Marker>.of(marker),
                onMapCreated: (GoogleMapController controller) {
                  googleMapController.complete(controller);
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  // height: MediaQuery.of(context).size.height * 0.23,
                  color: AppColors.whiteColor,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (widget.isPickup)
                            ? 'Pickup Address'
                            : 'Delivery Address',
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                          elevation: 0,
                          color: AppColors.whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.blackColor,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: SizedBox(
                                    // width:
                                    //     MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      (widget.isPickup)
                                          ? pickupLocation.text
                                          : deliveryLocation.text,
                                      maxLines: 1,
                                      style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          widget.createOrderState(() {});
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                              color: AppColors.backGroundColor,
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1.0,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              )),
                          child: Center(
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
