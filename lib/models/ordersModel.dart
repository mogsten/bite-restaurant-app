import 'package:bite_restaurant/models/customerDetailsModel.dart';
import 'package:bite_restaurant/models/orderDetailsModel.dart';
import 'package:json_annotation/json_annotation.dart';

class Orders {
  final int id;
  CustomerDetails customer;
  final String extra_notes;
  final String delivery_address;
  final String status;
  OrderDetails orderDetails;

  @JsonKey(name: 'customer')
  CustomerDetails customerDet;

  Orders({
  this.id, this.customer, this.orderDetails, this.extra_notes, this.delivery_address, this.status
  });

  factory Orders.fromJson(dynamic parsedJson) {
    return Orders(
      id: parsedJson["id"] as int,
      customer: CustomerDetails.fromJson(parsedJson["customer"]),
      extra_notes: parsedJson['extra_notes'] as String,
      delivery_address: parsedJson['address'] as String,
      status: parsedJson['status'] as String,
      // orderDetails: OrderDetails.fromJson(parsedJson["order_details"] as List)
    );
  }
  @override
  String toString() {
    return '{ ${this.id}, ${this.customer}}';
  }
}