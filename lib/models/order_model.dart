class OrderModel {
  String? orderId;
  String? userId;
  String? driverId;
  String? pickupLocation;
  String? deliveryLocation;
  String? createdAt;
  String? deliveredAt;
  String? status;
  bool? isAccepted;
  bool? isActive;
  bool? isDelivered;
  List<Map>? orderItems;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.driverId,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.createdAt,
    required this.deliveredAt,
    required this.isAccepted,
    required this.isActive,
    required this.isDelivered,
    required this.orderItems,
    required this.status,
  });

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
    };
  }
}
