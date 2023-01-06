import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../resources/api_endpoint.dart';

class LocationRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> get_storage() async {
    dynamic response = await apiServices.get(ApiEndpoint.storageUrl);

    try {
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> update_item_storage(dynamic data, String id) async {
    dynamic response = await apiServices.post('${ApiEndpoint.locationUpdateUrl}/$id', data);

    try {
      return response;
    } catch (e) {
      throw e;
    }
  }
}