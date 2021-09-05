import 'package:shop_app/models/homemodel.dart';

class CategoriesModel {
  bool? status;
  DataCategoriesModel? data;
  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataCategoriesModel.fromjson(json['data']);
  }
}

class DataCategoriesModel {
  List<DataModel> categories = [];
  DataCategoriesModel.fromjson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      categories.add(DataModel.fromjson(element));
    });
  }
}

class DataModel {
  int? id;
  String? image;
  String? name;
  DataModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}
