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
  @HiveField(6)
  String CountM;
  @HiveField(7)
  int QuantityM;
  @HiveField(8)
  String purchaseAmountM;

  itemModel({
    required this.ItemPicM,
    required this.CategoryM,
    required this.ItemNameM,
    required this.ColorM,
    required this.PriceM,
    required this.BrandM,
    this.CountM = '0',
    this.QuantityM = 0,
    required this.purchaseAmountM,
  });
  get QuatityM => null;
}

@HiveType(typeId: 2)
class customerModel extends HiveObject {
  @HiveField(0)
  String customerNameM;
  @HiveField(1)
  String customerNumberM;
  @HiveField(2)
  final List<itemModel> selectedItemsM;
  @HiveField(3)
  double sellTotalM;

  customerModel({
    required this.customerNameM,
    required this.customerNumberM,
    required this.selectedItemsM,
    required this.sellTotalM,
  });
}

@HiveType(typeId: 3)
class invoiceModel extends HiveObject {
  @HiveField(0)
  String invoiceM;
  @HiveField(1)
  DateTime invoicedateTimeM;
  @HiveField(2)
  double InvoiceTotalAmountM;

  invoiceModel({
    required this.invoiceM,
    required this.invoicedateTimeM,
    required this.InvoiceTotalAmountM
    });
}
