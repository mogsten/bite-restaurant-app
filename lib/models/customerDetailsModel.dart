import 'package:json_annotation/json_annotation.dart';

class CustomerDetails {
  String name;
  String address;

  CustomerDetails({this.name, this.address});

  factory CustomerDetails.fromJson(dynamic parsedJson) {

    return CustomerDetails(
      name: parsedJson['name'] as String,
      address: parsedJson['address'] as String
    );
  }

}