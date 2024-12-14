class OrderModel {
  String? orderId;
  String? userId;
  String? driverId;
  String? pickupLocation;
  String? deliveryLocation;
  String? pickuplatitude;
  String? pickupLongitude;
  String? deliverylatitude;
  String? deliveryLongitude;
  String? createdAt;
  String? deliveredAt;
  String? status;
  String? trackingStatus;
  bool? isAccepted;
  bool? isActive;
  bool? isDelivered;
  bool? isPicked;
  List? orderItems;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.driverId,
      required this.pickupLocation,
      required this.deliveryLocation,
      required this.pickupLongitude,
      required this.pickuplatitude,
      required this.deliveryLongitude,
      required this.deliverylatitude,
      required this.createdAt,
      required this.deliveredAt,
      required this.isAccepted,
      required this.isActive,
      required this.isDelivered,
      required this.orderItems,
      required this.status,
      required this.isPicked,
      required this.trackingStatus});

  OrderModel.fromMap(Map<String, dynamic> map) {
    orderId = map["orderId"];
    userId = map["userId"];
    driverId = map["driverId"];
    pickupLocation = map["pickupLocation"];
    deliveryLocation = map["deliveryLocation"];
    createdAt = map["createdAt"];
    deliveredAt = map["deliveredAt"];
    isAccepted = map["isAccepted"];
    isActive = map["isActive"];
    isDelivered = map["isDelivered"];
    orderItems = map["orderItems"];
    status = map["status"];
    trackingStatus = map["trackingStatus"] ?? "placed";
    isPicked = map["isPicked"] ?? false;
  }

  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "userId": userId,
      "driverId": driverId,
      "pickupLocation": pickupLocation,
      "deliveryLocation": deliveryLocation,
      "createdAt": createdAt,
      "deliveredAt": deliveredAt,
      "isAccepted": isAccepted,
      "isActive": isActive,
      "isDelivered": isDelivered,
      "orderItems": orderItems,
      "status": status,
      "trackingStatus": trackingStatus,
      "isPicked": isPicked,
    };
  }
}
