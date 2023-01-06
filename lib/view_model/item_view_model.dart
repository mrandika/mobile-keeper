import 'package:flutter/material.dart';
import 'package:keeper/model/response/item_response.dart';
import '../model/data/item.dart';
import '../repository/item_repository.dart';

class ItemViewModel with ChangeNotifier {
  final repo = ItemRepository();

  // State
  bool _is_loading = false;
  bool _is_error = false;
  List<Item>? _items;

  bool get is_loading => _is_loading;
  bool get is_error => _is_error;
  List<Item>? get items => _items;

  setLoading(bool state) {
    _is_loading = state;
    notifyListeners();
  }

  setError(bool state) {
    _is_error = state;
    notifyListeners();
  }

  setItems(List<Item>? items) {
    _items = items;
    notifyListeners();
  }

  Future<void> get_item() async {
    setLoading(true);
    setError(false);

    repo.get_item().then((value) async {
      setLoading(false);

      // Saving the data
      setItems(ItemResponse.fromJson(value).data);
    }).onError((error, stackTrace) {
      setLoading(false);
      setError(true);
    });
  }

  Future<void> store_item(dynamic data, BuildContext context) async {
    setLoading(true);
    setError(false);

    repo.store_item(data).then((value) async {
      setLoading(false);

      // Get the data
      get_item();

      // Navigate back
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      setError(true);
    });
  }
}