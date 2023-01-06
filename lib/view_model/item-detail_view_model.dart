import 'package:flutter/material.dart';

import '../model/data/item.dart';
import '../repository/item_repository.dart';

class ItemDetailViewModel with ChangeNotifier {
  final repo = ItemRepository();

  // State
  bool _is_loading = false;
  bool _is_error = false;
  Item? _item;

  bool get is_loading => _is_loading;
  bool get is_error => _is_error;
  Item? get item => _item;

  setLoading(bool state) {
    _is_loading = state;
    notifyListeners();
  }

  setError(bool state) {
    _is_error = state;
    notifyListeners();
  }

  setItems(Item? item) {
    _item = item;
    notifyListeners();
  }

  Future<void> get_item(String id) async {
    setLoading(true);
    setError(false);

    repo.get_item_detail(id).then((value) async {
      setLoading(false);

      // Saving the data
      setItems(Item.fromJson(value['data']));
    }).onError((error, stackTrace) {
      setLoading(false);
      setError(true);
    });
  }

  Future<void> update_item(dynamic data, String id, BuildContext context) async {
    setLoading(true);
    setError(false);

    repo.update_item(data, id).then((value) async {
      setLoading(false);

      // Get the data
      get_item(id);

      // Navigate back
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      setError(true);
    });
  }

  Future<void> update_storage_stock(dynamic data, String id, BuildContext context) async {
    setLoading(true);
    setError(false);

    repo.update_item(data, id).then((value) async {
      setLoading(false);

      // Get the data
      get_item(id);

      // Navigate back
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      setError(true);
    });
  }

  Future<void> destroy_item(String id, BuildContext context) async {
    setLoading(true);
    setError(false);

    repo.destroy_item(id).then((value) async {
      setLoading(false);

      // Navigate back
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoading(false);
      setError(true);
    });
  }
}