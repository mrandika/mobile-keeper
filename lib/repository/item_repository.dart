import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/api_endpoint.dart';

class ItemRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> get_item() async {
    dynamic response = await apiServices.get(ApiEndpoint.itemUrl);

    try {
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> store_item(dynamic data) async {
    dynamic response = await apiServices.post(ApiEndpoint.itemStoreUrl, data);

    try {
      return response;
    } catch (e) {
      throw e;
    }
  }
}