import 'package:keeper/resources/api_endpoint.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';

class AuthRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<dynamic> login(dynamic data) async {
    dynamic response = await apiServices.post(ApiEndpoint.loginUrl, data);

    try {
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> get_profile() async {
    dynamic response = await apiServices.get(ApiEndpoint.profileUrl);

    try {
      return response;
    } catch (e) {
      throw e;
    }
  }
}