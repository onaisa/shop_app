class HomeModel {
  late bool status;
  late DataHomeModel data;

  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataHomeModel.fromjson(json['data']);
  }
}

class DataHomeModel {
  late List<BannerModel> banners = [];
  late List<ProductModel> products = [];
  DataHomeModel.fromjson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      if (BannerModel.fromjson(element).id == 11 ||
          BannerModel.fromjson(element).id == 12 ||
          BannerModel.fromjson(element).id == 19)
        banners.add(BannerModel.fromjson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromjson(element));
    });
  }
}

class BannerModel {
  late String image;
  late int id;
  BannerModel.fromjson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFav;
  late bool inCart;

  ProductModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFav = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
