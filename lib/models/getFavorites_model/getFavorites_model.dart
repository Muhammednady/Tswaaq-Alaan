
class GetFavoritesModel {
  bool? status;
  String? message;
  AllDataFavorites? data;

  GetFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AllDataFavorites.fromJson(json['data']) :null;
  }
}

class AllDataFavorites {
  int? currentPage;
  List<DataFavorites> data = [];

  AllDataFavorites.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataFavorites.fromJson(element));
    });
  }
}

class DataFavorites {
  int? id;
  ProductModel? productModel;
  DataFavorites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productModel = ProductModel.fromJson(json['product']);
  }
}

class ProductModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['íd'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
