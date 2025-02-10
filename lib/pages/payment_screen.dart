import 'package:flutter/material.dart';
import 'package:woocommerse_app/models/payment_method.dart';
import 'package:woocommerse_app/pages/base_page.dart';
import 'package:woocommerse_app/pages/checkout_base.dart';
import 'package:woocommerse_app/widgets/widget_payment_method_list_item.dart';

class PaymentMethodsWidget extends CheckoutBasePage {
  const PaymentMethodsWidget({super.key});

  @override
  State<PaymentMethodsWidget> createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends CheckoutBasePageState<PaymentMethodsWidget> {
  

  @override
  void initState() {
    currentPage = 1;
    super.initState();
  }

  @override
  Widget pageUI() {
    PaymentMethodList list = PaymentMethodList(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //SizedBox(height: 15),
          // if (list.paymentList.isNotEmpty)
          //   Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 20),
          //     child: ListTile(
          //       contentPadding: EdgeInsets.symmetric(vertical: 0),
          //       leading: Icon(
          //         Icons.payment,
          //         color: Theme.of(context).hintColor,
          //       ),
          //       title: Text(
          //         "Payment Options",
          //         maxLines: 1,
          //         overflow: TextOverflow.ellipsis,
          //       ),
          //       subtitle: Text("Select your preferred Payment Mode"),
          //     ),
          //   ),
          // SizedBox(height: 10),
          // ListView.separated(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   primary: false,
          //   itemBuilder: (context, index) {
          //     return PaymentMethodListItem(
          //       paymentMethod: list.paymentList[index],
          //     );
          //   },
          //   separatorBuilder: (context, index) {
          //     return SizedBox(height: 10);
          //   },
          //   itemCount: list.paymentList.length
          // ),
          SizedBox(height: 15),
          if (list.cashList.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                leading: Icon(
                  Icons.monetization_on,
                  color: Theme.of(context).hintColor,
                ),
                title: Text(
                  "Cash on Delivery",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text("Select your preferred Payment Mode"),
              ),
            ),
          ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return PaymentMethodListItem(
                paymentMethod: list.cashList[index],
              
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemCount: list.cashList.length
          ),
        ],
      ),
    );
  }
}
