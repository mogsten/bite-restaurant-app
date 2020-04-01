import 'package:bite_restaurant/models/orderItemsModel.dart';
import 'package:json_annotation/json_annotation.dart';

class OrderDetails {
  ItemsinOrder itemsInOrder;

  OrderDetails({this.itemsInOrder});

  factory OrderDetails.fromJson(dynamic parsedJson) {

    return OrderDetails(
      itemsInOrder: ItemsinOrder.fromJson(parsedJson["meal"])
    );
  }

}