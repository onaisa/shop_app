class ChangeFavoriteorcartModel {
  bool? status;
  String? message;

  ChangeFavoriteorcartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
