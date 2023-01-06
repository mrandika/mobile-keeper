import 'package:flutter/material.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/view/screen/item/item-detail-screen.dart';
import 'package:keeper/view_model/item_view_model.dart';
import 'package:provider/provider.dart';

import '../../component/error.dart';
import '../../component/loading.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  void initState() {
    super.initState();

    final view_model = Provider.of<ItemViewModel>(context, listen: false);

    if (view_model.items?.isEmpty ?? true) {
      view_model.get_item();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromRGBO(177, 118, 60, 1),
        icon: const Icon(Icons.add),
        label: const Text('BARU'),
        onPressed: () {
          Navigator.pushNamed(context, AppRouters.addItem);
        },
      ),
      body: Consumer<ItemViewModel>(
        builder: (context, value, _) {
          if (value.is_loading) {
            return const LoadingComponent();
          } else if (value.is_error) {
            return const ErrorComponent();
          } else {
            return RefreshIndicator(
                onRefresh: () => value.get_item(),
                child: ListView.separated(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    itemCount: value.items!.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        child: Container(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(value.items?.elementAt(index).sku ?? ''),
                                  Text('Rp. ${value.items?.elementAt(index).price}'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    value.items?.elementAt(index).name ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  Text(
                                    'Stok: ${value.items?.elementAt(index).locations?.fold(0, (sum, item) => sum + item.stock!)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, AppRouters.itemDetail, arguments: value.items?.elementAt(index).id);
                        },
                      );
                    },
                  separatorBuilder: (BuildContext context, _) => const Divider(),
                )
            );
          }
        },
      )
    );
  }
}
