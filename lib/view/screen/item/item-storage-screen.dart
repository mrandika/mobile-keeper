import 'package:flutter/material.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/view_model/item-detail_view_model.dart';
import 'package:provider/provider.dart';

class ItemStorageScreen extends StatefulWidget {
  const ItemStorageScreen({Key? key}) : super(key: key);

  @override
  State<ItemStorageScreen> createState() => _ItemStorageScreenState();
}

class _ItemStorageScreenState extends State<ItemStorageScreen> {
  @override
  Widget build(BuildContext context) {
    final view_model = Provider.of<ItemDetailViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(view_model.item?.name ?? ''),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: view_model.item?.locations?.length ?? 0,
          itemBuilder: (_, int index) {
            return InkWell(
              child: Row(
                children: [
                  Image.asset('images/icn_storage.png', width: 60, height: 60),
                  SizedBox(width: 16),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'KODE PENYIMPANAN',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '${view_model.item?.locations!.elementAt(index).storage!.row!.code}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRouters.editItemStorage, arguments: index);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider()
      )
    );
  }
}
