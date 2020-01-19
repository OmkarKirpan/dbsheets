import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  String sku;
  @HiveField(1)
  String name;
  @HiveField(2)
  String desc;
  @HiveField(3)
  String price;

  Product(this.sku, this.name, this.desc, this.price);

  Product.fromJson(Map<String, dynamic> json)
      : sku = json['sku'],
        name = json['name'],
        desc = json['desc'],
        price = json['price'];
}
