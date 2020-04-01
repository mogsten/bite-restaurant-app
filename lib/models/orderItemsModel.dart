import 'package:json_annotation/json_annotation.dart';

class ItemsinOrder {
  String name;
  String address;

  ItemsinOrder({this.name, this.address});

  factory ItemsinOrder.fromJson(dynamic parsedJson) {

    return ItemsinOrder(
      name: parsedJson['name'] as String,
      address: parsedJson['address'] as String
    );
  }

}