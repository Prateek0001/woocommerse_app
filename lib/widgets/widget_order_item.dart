import 'package:flutter/material.dart';
import 'package:dunn_oil/models/order.dart';
import 'package:dunn_oil/pages/order_detail.dart';

class WidgetOrderItem extends StatelessWidget {
  final OrderModel orderModel;
  const WidgetOrderItem({super.key,required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _orderStatus(orderModel.status ?? ''),
          Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(
                  Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  Text(
                    "Order ID",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Text(
                orderModel.orderId.toString(),
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(
                  Icon(
                    Icons.today,
                    color: Colors.blue,
                  ),
                  Text(
                    "Order Date",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
              Text(
                orderModel.orderDate.toString(),
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              flatButton("Order Details",Colors.green,(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetailPage(orderId: orderModel.orderId ?? 0,)));
              })
            ],
          )
        ],
      ),
    );
  }

  Widget iconText(Icon iconWidget, Text textWidget) {
    return Row(
      children: [
        iconWidget,
        SizedBox(
          width: 5,
        ),
        textWidget
      ],
    );
  }

  Widget flatButton(String text, Color color, Function onPressed) {
    return Center(
        child: ElevatedButton.icon(
          iconAlignment: IconAlignment.end,
          onPressed: () {
            // Action on button press
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: const Icon(Icons.chevron_right, color: Colors.white),
          label: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
  }

  Widget _orderStatus(String status){
    Icon icon;
    Color color;

    if ( status == "pending" || status == "processing" || status == "on-hold"){
      icon = Icon(Icons.timer,color: Colors.orange,);
      color = Colors.orange;
    } else if (status == "completed"){
      icon = Icon(Icons.check,color: Colors.green,);
      color = Colors.green;
    } else if (status == "cancelled" || status == "refunded" || status == "failed"){
      icon = Icon(Icons.clear,color: Colors.blue,);
      color = Colors.blue;
    } else {
      icon = Icon(Icons.clear,color: Colors.blue,);
      color = Colors.blue;
    }

    return iconText(icon, Text("Order $status",style: TextStyle(fontSize: 15,color: color,fontWeight: FontWeight.bold),));
  }
}
