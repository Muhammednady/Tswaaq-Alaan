

class CategoriesModel {
  bool? status;
  String? message;
  categoriesDataModel? data;
  
  CategoriesModel.fromJson(Map<String, dynamic> json) {
     status = json['status'];
     message = json['message'];
     data = categoriesDataModel.fromJson(json['data']);


  }
}

class categoriesDataModel {
  int? currentPage;
  List<DataCModel> data = [];

  categoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataCModel.fromJson(element));
    });
  }
}

class DataCModel {
  int? id;
  String? name;
  String? image;

  DataCModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
