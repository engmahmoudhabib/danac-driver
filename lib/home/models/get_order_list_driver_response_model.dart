class GetDriverOrdersListResponseModel {
  int? id;
  OutputReceipt? outputReceipt;
  Employee? employee;
  bool? isDelivered;

  GetDriverOrdersListResponseModel(
      {this.id, this.outputReceipt, this.employee, this.isDelivered});

  GetDriverOrdersListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outputReceipt = json['output_receipt'] != null
        ? new OutputReceipt.fromJson(json['output_receipt'])
        : null;
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    isDelivered = json['is_delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.outputReceipt != null) {
      data['output_receipt'] = this.outputReceipt!.toJson();
    }
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    data['is_delivered'] = this.isDelivered;
    return data;
  }
}

class OutputReceipt {
  int? id; 
  int? verifyCode;
  String? address;
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
  int? client; 
  String? clientName; 
  int? employee;
  List<int>? products;

  OutputReceipt(
      {this.id,
      this.verifyCode,
      this.phonenumber,
      this.recivePyement,
      this.discount,
      this.reclaimedProducts,
      this.previousDepts,
      this.remainingAmount,
      this.date,
      this.barcode,
      this.address,
      this.location,
      this.delivered,
      this.clientName,
      this.client,
      this.employee,
      this.products});

  OutputReceipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verifyCode = json['verify_code'] ?? 0;
    phonenumber = json['phonenumber'];
    clientName = json['client_name'];
    address = json['address'];
    recivePyement = double.parse(json['recive_pyement'] != null ?json['recive_pyement'].toString() : '0.0');
    discount = double.parse(json['discount'] != null ?json['discount'].toString(): '0.0');
    reclaimedProducts = double.parse(json['Reclaimed_products'] != null ?json['Reclaimed_products'].toString(): '0.0');
    previousDepts = double.parse(json['previous_depts'] != null ?json['previous_depts'].toString(): '0.0');
    remainingAmount = double.parse(json['remaining_amount'] != null ?json['remaining_amount'].toString(): '0.0');
    date = json['date'];
    barcode = json['barcode'];
    location = json['location'];
    delivered = json['delivered'];
    client = json['client'];
    employee = json['employee'];
    products = json['products'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['client'] = this.client;
    data['employee'] = this.employee;
    data['products'] = this.products;
    return data;
  }
}

class Employee {
  int? id;
  String? name;
  String? phonenumber;
  String? jobPosition;
  int? truckNum;
  String? location;
  double? salary;
  double? salePercentage;
  String? address;
  String? notes;
  String? birthday;

  Employee(
      {this.id,
      this.name,
      this.phonenumber,
      this.jobPosition,
      this.truckNum,
      this.location,
      this.salary,
      this.salePercentage,
      this.address,
      this.notes,
      this.birthday});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phonenumber = json['phonenumber'];
    jobPosition = json['job_position'];
    truckNum = json['truck_num'];
    location = json['location'];
    salary = double.parse(json['salary'].toString());
    salePercentage = double.parse(json['sale_percentage'].toString());
    address = json['address'];
    notes = json['notes'];
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phonenumber'] = this.phonenumber;
    data['job_position'] = this.jobPosition;
    data['truck_num'] = this.truckNum;
    data['location'] = this.location;
    data['salary'] = this.salary;
    data['sale_percentage'] = this.salePercentage;
    data['address'] = this.address;
    data['notes'] = this.notes;
    data['birthday'] = this.birthday;
    return data;
  }
}
