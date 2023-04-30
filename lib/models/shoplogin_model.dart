class ShopLogInModel {
  bool? status;
  String? message;
  UserData? data;

  ShopLogInModel.FromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] == null ? null : UserData.FromJson(json['data']);
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.FromJson(Map<String, dynamic> userdata) {
    id = userdata['id'];
    name = userdata['name'];
    email = userdata['email'];
    phone = userdata['phone'];
    image = userdata['image'];
    points = userdata['points'];
    credit = userdata['credit'];
    token = userdata['token'];
  }
}
