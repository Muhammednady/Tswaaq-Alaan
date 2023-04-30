class HomeModel {
  bool? status;
  String? message;
  DataModel? data;
 // List<BannersModel>? banners;
 // List<ProductsModel>? products;
 // String? ad;

  HomeModel(
      this.status, this.message,this.data);
      
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = DataModel.fromJson(json['data']);

   /* json['data']['banners'].foreach((element) {
      banners!.add(BannersModel.fromJson(element));
    });
    json['data']['products'].foreach((element) {
      products!.add(ProductsModel.fromJson(element));
    });

    ad = json['data']['ad'];*/
  }
}

class DataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  String? ad;

  DataModel.fromJson(Map<String, dynamic> json){

    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });

    ad = json['ad'];
  }
}

class BannersModel {
  int? id;
  String? image;
  Map? category;
  Map? product;

  BannersModel(this.id, this.image, this.category, this.product);

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  List<dynamic>? images;
  bool? inFavorites;
  bool? inCarts;

  ProductsModel(this.id, this.price, this.oldPrice, this.discount, this.image,
      this.name, this.description, this.inFavorites, this.inCarts);
  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCarts = json['in_cart'];
  }
}
