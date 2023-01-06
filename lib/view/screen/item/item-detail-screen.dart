import 'package:flutter/material.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/view_model/item-detail_view_model.dart';
import 'package:keeper/view_model/item_view_model.dart';
import 'package:provider/provider.dart';

import '../../../model/data/item.dart';
import '../../component/error.dart';
import '../../component/loading.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  void initState() {
    super.initState();

    final view_model = Provider.of<ItemDetailViewModel>(context, listen: false);
    view_model.get_item(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final view_model = Provider.of<ItemDetailViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(view_model.item?.name ?? ''),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouters.editItem);
              },
              icon: Icon(Icons.edit)
          )
        ],
      ),
      body: Consumer<ItemDetailViewModel>(
        builder: (context, value, _) {
          if (value.is_loading) {
            return const LoadingComponent();
          } else if (value.is_error) {
            return const ErrorComponent();
          } else {
            return Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          Image.asset('images/icn_item.png', width: 120, height: 120),
                          SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'NAMA BARANG',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                value.item?.name ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 16),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SKU',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                value.item?.sku ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 16),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'TOTAL STOCK',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                value.item?.locations?.fold(0, (sum, item) => sum + item.stock!).toString() ?? '',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 16),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'HARGA BARANG',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Rp. ${value.item?.price}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Divider(),
                              SizedBox(height: 16),
                            ],
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'TOTAL TEMPAT PENYIMPANAN',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${value.item?.locations?.length} Lokasi',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                                Divider(),
                                SizedBox(height: 16),
                              ],
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, AppRouters.itemStorages);
                            },
                          ),
                        ],
                      )
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                          child: Container(
                            width: double.infinity,
                            child: OutlinedButton(
                                onPressed: () => _dialogBuilder(context, value.item),
                                child: const Text(
                                  "Hapus",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600
                                  ),
                                )
                            ),
                          )
                      )
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context, Item? item) {
    final view_model = Provider.of<ItemDetailViewModel>(context, listen: false);
    final item_view_model = Provider.of<ItemViewModel>(context, listen: false);

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus ${item?.name}?'),
          content: const Text('Data yang berkaitan dengan barang ini akan dihapus. Aksi ini TIDAK DAPAT dikembalikan dan akan dicatat pada log sistem.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Ya, Hapus',
                style: TextStyle(
                  color: Colors.red
                ),
              ),
              onPressed: () {
                view_model.destroy_item(item?.id ?? '', context);
                Navigator.pop(context);
                item_view_model.get_item();
              },
            ),
          ],
        );
      },
    );
  }
}
