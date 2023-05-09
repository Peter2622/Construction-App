import '../model/allsitemodle.dart';
import '../model/stockmodel.dart';

class UserEntrySingleton {
 

  static final UserEntrySingleton _singleton = UserEntrySingleton._internal();
   GetAllsiteModel? userEntry;
  String status = "";

  factory UserEntrySingleton() {
    return _singleton;
  }

  UserEntrySingleton._internal();
}

class StockSingleton {
 

  static final StockSingleton _singleton = StockSingleton._internal();
   StockModel? stock;
  String status = "";

  factory StockSingleton() {
    return _singleton;
  }

  StockSingleton._internal();
}
