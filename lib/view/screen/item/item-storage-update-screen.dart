import 'package:flutter/material.dart';
import 'package:keeper/view_model/location_view_model.dart';
import 'package:provider/provider.dart';

import '../../../view_model/item-detail_view_model.dart';
import '../../../view_model/item_view_model.dart';

class ItemStorageUpdateScreen extends StatefulWidget {
  const ItemStorageUpdateScreen({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<ItemStorageUpdateScreen> createState() => _ItemStorageUpdateScreenState();
}

class _ItemStorageUpdateScreenState extends State<ItemStorageUpdateScreen> {
  TextEditingController stock_input = TextEditingController();
  FocusNode stock_focus = FocusNode();

  String stock = '0';

  @override
  void initState() {
    super.initState();

    final view_model = Provider.of<ItemDetailViewModel>(context, listen: false);
    stock_input.text = view_model.item?.locations?.elementAt(widget.index).stock.toString() ?? '0';
  }

  @override
  void dispose() {
    super.dispose();
    stock_input.dispose();
    stock_focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final view_model = Provider.of<ItemDetailViewModel>(context);
    final item_view_model = Provider.of<ItemViewModel>(context);
    final location_view_model = Provider.of<LocationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(view_model.item?.name ?? ''),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
              children: [
                Expanded(
                    child: Column(
                        children: [
                          Image.asset('images/icn_storage.png', width: 120, height: 120),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'KODE PENYIMPANAN',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    view_model.item?.locations?.elementAt(widget.index).storage?.row?.code ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 16),
                                ],
                              ),
                              TextField(
                                controller: stock_input,
                                focusNode: stock_focus,
                                keyboardType: TextInputType.number,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Stock Barang'
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    stock = value;
                                  });
                                },
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                if (!view_model.is_loading) {
                                  Map data = {
                                    'item_id': view_model.item?.id ?? '',
                                    'warehouse_id': view_model.item?.locations?.elementAt(widget.index).storage?.aisle?.warehouseId ?? '',
                                    'storage_id': view_model.item?.locations?.elementAt(widget.index).storage?.id ?? '',
                                    'stock': stock_input.text
                                  };

                                  location_view_model.update_storage_stock(data, view_model.item?.locations?.elementAt(widget.index).id ?? '', context).then((value) => {
                                    item_view_model.get_item().then((value) => {
                                      view_model.get_item(view_model.item?.id ?? '')
                                    })
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(100, 40)
                              ),
                              child: view_model.is_loading ? Container(
                                width: 24,
                                height: 24,
                                padding: const EdgeInsets.all(2.0),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                ),
                              ) : const Text('Simpan'),
                            ),
                          )
                        ]
                    )
                )
              ]
          )
      ),
    );
  }
}
