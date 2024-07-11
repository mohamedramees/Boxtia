import 'package:hive/hive.dart';
part 'DB_Model.g.dart';

@HiveType(typeId: 0)
class userModel extends HiveObject {
  @HiveField(0)
  String bussinessName;
  @HiveField(1)
  String bussiType;
  @HiveField(2)
  String oName;
  @HiveField(3)
  String place;
  @HiveField(4)
  String mobileNumber;

  userModel({
    required this.bussinessName,
    required this.bussiType,
    required this.oName,
    required this.place,
    required this.mobileNumber,
  });
}

@HiveType(typeId: 1)
class itemModel extends HiveObject {
  @HiveField(0)
  String ItemPicM;
  @HiveField(1)
  String CategoryM;
  @HiveField(2)
  String ItemNameM;
  @HiveField(3)
  String ColorM;
  @HiveField(4)
  String PriceM;
  @HiveField(5)
  String BrandM;

  itemModel({
    required this.ItemPicM,
    required this.CategoryM,
    required this.ItemNameM,
    required this.ColorM,
    required this.PriceM,
    required this.BrandM,
  });
}
