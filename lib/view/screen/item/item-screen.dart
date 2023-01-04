import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:keeper/model/data/item.dart';
import 'package:keeper/utils/AppRoutes.dart';
import 'package:keeper/view_model/item_view_model.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final view_model = Provider.of<ItemViewModel>(context, listen: false);
      view_model.get_item(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final view_model = context.watch<ItemViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromRGBO(177, 118, 60, 1),
        icon: Icon(Icons.add),
        label: const Text('BARU'),
        onPressed: () {
          Navigator.pushNamed(context, AppRouters.addItem);
        },
      ),
      body: Container(
        child: Consumer<ItemViewModel>(
          builder: (context, value, _) {
            if (value.is_loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.is_error) {
              return const Center(
                child: Text('Error!'),
              );
            } else {
              return RefreshIndicator(
                  onRefresh: get_items,
                  child: ListView.builder(
                      itemCount: value.items?.length ?? 0,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(value.items?.elementAt(index).name ?? ''),
                        );
                      }
                  )
              );
            }
          },
        )
      ),
    );
  }

  Future<void> get_items() async {
    Provider.of<ItemViewModel>(context).get_item(context);
  }
}
