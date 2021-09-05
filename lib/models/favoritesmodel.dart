class GetFavModel {
  bool? status;
  String? message;
  GetFavDataModel? data;

  GetFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = GetFavDataModel.fromJson(json['data']);
  }
}

class GetFavDataModel {
  List<DataFavModel?> favourites = [];
  GetFavDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      favourites.add(DataFavModel.fromJson(element));
    });
  }
}

class DataFavModel {
  int? id;
  ProductModel? product;

  DataFavModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}

class ProductModel {
  int? id;
  dynamic price;

  dynamic oldPrice;

  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];

    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
