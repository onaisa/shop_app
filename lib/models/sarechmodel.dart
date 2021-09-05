class SearchModel {
  bool? status;

  Datasearch? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = Datasearch.fromJson(json['data']);
  }
}

class Datasearch {
  List<ProductsearchModel?> datasearch = [];

  Datasearch.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      datasearch.add(ProductsearchModel.fromJson(v));
    });
  }
}

class ProductsearchModel {
  int? id;
  dynamic price;

  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;

  ProductsearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];

    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}

// class SearchModel {
//   bool? status;
//   Null message;
//   Data? data;

//   SearchModel({this.status, this.message, this.data});

//   SearchModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {
//   int? currentPage;
//   List<Data>? data=[];
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   Null nextPageUrl;
//   String? path;
//   int? perPage;
//   Null prevPageUrl;
//   int? to;
//   int? total;

//   DataSare(
//       {this.currentPage,
//       this.data,
//       this.firstPageUrl,
//       this.from,
//       this.lastPage,
//       this.lastPageUrl,
//       this.nextPageUrl,
//       this.path,
//       this.perPage,
//       this.prevPageUrl,
//       this.to,
//       this.total});

//   Data.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     if (json['data'] != null) {
      
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//     firstPageUrl = json['first_page_url'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     lastPageUrl = json['last_page_url'];
//     nextPageUrl = json['next_page_url'];
//     path = json['path'];
//     perPage = json['per_page'];
//     prevPageUrl = json['prev_page_url'];
//     to = json['to'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['first_page_url'] = this.firstPageUrl;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['last_page_url'] = this.lastPageUrl;
//     data['next_page_url'] = this.nextPageUrl;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['prev_page_url'] = this.prevPageUrl;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }

// class Data {
//   int? id;
//   int? price;
//   String? image;
//   String? name;
//   String? description;
//   List<String>? images;
//   bool? inFavorites;
//   bool? inCart;

//   Data(
//       {this.id,
//       this.price,
//       this.image,
//       this.name,
//       this.description,
//       this.images,
//       this.inFavorites,
//       this.inCart});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }

  
// }

