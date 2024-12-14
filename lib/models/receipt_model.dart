class ReceiptModel {
  String? receiptId;
  String? merchantAddress;
  String? merchantName;
  String? merchantPhone;
  String? merchantCity;
  String? receiptDate;
  double? totalAmount;
  double? taxAmount;
  int? itemCount;
  String? points;
  String? status;
  List<ReceiptProduct>? receiptProducts;

  ReceiptModel({
    required this.receiptId,
    required this.merchantAddress,
    required this.merchantName,
    required this.merchantPhone,
    required this.merchantCity,
    required this.receiptDate,
    required this.totalAmount,
    required this.taxAmount,
    required this.itemCount,
    required this.points,
    required this.status,
    required this.receiptProducts,
  });

  ReceiptModel.fromJson(Map<String, dynamic> amazonData) {
    Map json = amazonData['extracted_data'][0];
    receiptId = json["financial_document_information"]['invoice_receipt_id'];
    merchantName = json["merchant_information"]['name'];
    merchantPhone = json["merchant_information"]['phone'];
    merchantCity = json["merchant_information"]['city'];
    merchantAddress = json["merchant_information"]['address'];
    receiptDate = json["financial_document_information"]['invoice_date'];
    totalAmount = json["payment_information"]['total'] ?? 0;
    taxAmount = json["payment_information"]['total_tax'] ?? 0;
    itemCount = (json["item_lines"] != null) ? json["item_lines"].length : 0;
    points = amazonData["points"];
    status = amazonData["status"];
    receiptProducts =
        (json["item_lines"] != null) ? getProducts(json["item_lines"]) : [];
  }

  List<ReceiptProduct> getProducts(List lineItems) {
    List<ReceiptProduct> products = [];
    for (var item in lineItems) {
      ReceiptProduct receiptProduct = ReceiptProduct.fromJson(item);
      products.add(receiptProduct);
    }
    return products;
  }
}

class ReceiptProduct {
  String? productName;
  double? productQty;
  double? productPrice;
  double? productTotal;

  ReceiptProduct({
    required this.productName,
    required this.productQty,
    required this.productPrice,
    required this.productTotal,
  });

  ReceiptProduct.fromJson(Map<String, dynamic> json) {
    productName = json["title"] ?? json["description"] ?? '';
    productQty = json["quantity"] ?? 0.0;
    productPrice = json["unit_price"] ?? 0.0;
    productTotal = json["amount_line"] ?? 0.0;
  }
}
