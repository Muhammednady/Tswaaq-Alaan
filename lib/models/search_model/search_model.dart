/*"status": true,
    "message": null,
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 88,
                "price":,
                "image":
                "name":  
*/
class SearchModel{
  bool? status;
  String? message;
  DataSearchModel? data;
  SearchModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = DataSearchModel.fromJson(json['data']);
  }
}

class DataSearchModel {
  int? currentPage;
  List<SearchProductModel> searchProducts = [];
  DataSearchModel.fromJson(Map<String,dynamic> json){

    currentPage = json['current_page'];
    json['data'].forEach((element){
      searchProducts.add(SearchProductModel.fromJson(element));
    });

  }

}

class SearchProductModel {

  
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCarts;  
  SearchProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price']; 
    discount = json['discount'];    
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCarts = json['in_cart'];


  }
}                
