import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/models/order.dart';
import 'package:woocommerse_app/provider/order_provider.dart';
import 'package:woocommerse_app/widgets/widget_order_item.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    var orderProvider = Provider.of<OrderProvider>(context,listen: false);
    orderProvider.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, orderModel, child) {
        if (orderModel.allOrders != null && orderModel.allOrders!.isNotEmpty) {
         return _listView(context, orderModel.allOrders ?? []);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _listView(BuildContext context, List<OrderModel> order) {
    return ListView(children: [
      ListView.builder(
        itemCount: order.length,
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: WidgetOrderItem(orderModel: order[index]),
          );
        },
      )
    ]);
  }
}
