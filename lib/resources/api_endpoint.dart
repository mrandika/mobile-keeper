class ApiEndpoint {
  static var baseUrl = "http://192.168.2.103:8000/api";

  static var loginUrl = "$baseUrl/login";
  static var logoutUrl = "$baseUrl/logout";
  static var profileUrl = "$baseUrl/profile";

  static var itemUrl = "$baseUrl/item";
  static var itemStoreUrl = "$baseUrl/item/store";
  static var itemDetailUrl = "$baseUrl/item/show";
  static var itemUpdateUrl = "$baseUrl/item/update";
  static var itemDestroyUrl = "$baseUrl/item/destroy";

  static var storageUrl = "$baseUrl/storage";
  static var locationUpdateUrl = "$baseUrl/item/location/update";
}