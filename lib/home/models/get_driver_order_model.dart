class GetDriverOrderResponseModel {
  Receipt? receipt;
  List<Products>? products;
  bool? isDelivered;

  GetDriverOrderResponseModel({this.receipt, this.products, this.isDelivered});

  GetDriverOrderResponseModel.fromJson(Map<String, dynamic> json) {
    receipt =
        json['receipt'] != null ? new Receipt.fromJson(json['receipt']) : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    isDelivered = json['is_delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.receipt != null) {
      data['receipt'] = this.receipt!.toJson();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['is_delivered'] = this.isDelivered;
    return data;
  }
}

class Receipt {
  int? id;
  int? client;
  String? clientName;
  String? address;
  List<int>? products;
  int? employee;
  int? verifyCode;
  String? phonenumber;
  double? recivePyement;
  double? discount;
  double? reclaimedProducts;
  double? previousDepts;
  double? remainingAmount;
  String? date;
  String? barcode;
  String? location;
  bool? delivered;

  Receipt(
      {this.id,
      this.client,
      this.clientName,
      this.address,
      this.products,
      this.employee,
      this.verifyCode,
      this.phonenumber,
      this.recivePyement,
      this.discount,
      this.reclaimedProducts,
      this.previousDepts,
      this.remainingAmount,
      this.date,
      this.barcode,
      this.location,
      this.delivered});

  Receipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'];
    clientName = json['client_name'];
    address = json['address'];
    products = json['products'].cast<int>();
    employee = json['employee'];
    verifyCode = json['verify_code'] ?? 0;
    phonenumber = json['phonenumber'];
    recivePyement = double.parse(json['recive_pyement'] != null ?json['recive_pyement'].toString() : '0.0');
    discount = double.parse(json['discount'] != null ?json['discount'].toString() : '0.0');
    reclaimedProducts = double.parse(json['Reclaimed_products'] != null ?json['Reclaimed_products'].toString() : '0.0');
    previousDepts = double.parse(json['previous_depts'] != null ?json['previous_depts'].toString() : '0.0');
    remainingAmount = double.parse(json['remaining_amount'] != null ?json['remaining_amount'].toString() : '0.0');
    date = json['date'];
    barcode = json['barcode'];
    location = json['location'];
    delivered = json['delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client'] = this.client;
    data['client_name'] = this.clientName;
    data['address'] = this.address;
    data['products'] = this.products;
    data['employee'] = this.employee;
    data['verify_code'] = this.verifyCode;
    data['phonenumber'] = this.phonenumber;
    data['recive_pyement'] = this.recivePyement;
    data['discount'] = this.discount;
    data['Reclaimed_products'] = this.reclaimedProducts;
    data['previous_depts'] = this.previousDepts;
    data['remaining_amount'] = this.remainingAmount;
    data['date'] = this.date;
    data['barcode'] = this.barcode;
    data['location'] = this.location;
    data['delivered'] = this.delivered;
    return data;
  }
}

class Products {
  int? products;
  int? quantity;
  double? total;
  double? discount;
  int? numPerItem;
  double? salePrice;
  String? product;
  String? image;

  Products({
    this.products,
    this.quantity,
    this.total,
    this.discount,
    this.numPerItem,
    this.salePrice,
    this.product,
    this.image,
  });

  Products.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    quantity = json['quantity'];
    total = double.parse(json['total'].toString());
    discount = double.parse(json['discount'].toString());
    numPerItem = json['num_per_item '];
    salePrice = double.parse(json['sale_price'].toString());
    product = json['product'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products'] = this.products;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['num_per_item '] = this.numPerItem;
    data['sale_price'] = this.salePrice;
    data['product'] = this.product;
    data['image'] = this.image;
    return data;
  }
}
