import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:keeper/view_model/item_view_model.dart';
import 'package:keeper/view_model/location_view_model.dart';
import 'package:provider/provider.dart';

class ItemAddScreen extends StatefulWidget {
  const ItemAddScreen({Key? key}) : super(key: key);

  @override
  State<ItemAddScreen> createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  TextEditingController name_input = TextEditingController();
  FocusNode name_focus = FocusNode();

  TextEditingController sku_input = TextEditingController();
  FocusNode sku_focus = FocusNode();

  TextEditingController price_input = TextEditingController();
  FocusNode price_focus = FocusNode();

  TextEditingController stock_input = TextEditingController();
  FocusNode stock_focus = FocusNode();

  String name = '';
  String sku = '';
  String price = '0';
  String stock = '0';

  String? storageId;

  @override
  void dispose() {
    super.dispose();
    name_input.dispose();
    name_focus.dispose();
    sku_input.dispose();
    sku_focus.dispose();
    price_input.dispose();
    price_focus.dispose();
    stock_input.dispose();
    stock_focus.dispose();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      sku = barcodeScanRes;
      sku_input.text = sku;
    });
  }

  @override
  void initState() {
    super.initState();

    final view_model = Provider.of<LocationViewModel>(context, listen: false);

    if (view_model.storages?.isEmpty ?? true) {
      view_model.get_storage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final view_model = Provider.of<ItemViewModel>(context);
    final storage_view_model = Provider.of<LocationViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Barang'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: name_input,
              focusNode: name_focus,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nama Barang'
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: sku_input,
                      focusNode: sku_focus,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kode SKU Barang'
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                    onPressed: () => scanBarcodeNormal(),
                    icon: Icon(Icons.camera_alt),
                    label: Text("Scan")
                )
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: price_input,
              focusNode: price_focus,
              keyboardType: TextInputType.number,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Harga Barang'
              ),
              onChanged: (value) {
                setState(() {
                  price = value;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButton(
              hint: const Text("Pilih Penyimpanan"),
              value: storageId,
              isExpanded: true,
              items: storage_view_model.storages?.map((item) {
                return DropdownMenuItem(
                  value: item.id ?? '',
                  child: Text(item.row?.code ?? ''),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  storageId = value!;
                });
              },
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if (!view_model.is_loading) {
                    Map data = {
                      'name': name_input.text,
                      'sku': sku_input.text,
                      'price': price_input.text,
                      'storage_id': storageId,
                      'stock': stock_input.text
                    };

                    view_model.store_item(data, context);
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
          ],
        ),
      )
    );
  }
}