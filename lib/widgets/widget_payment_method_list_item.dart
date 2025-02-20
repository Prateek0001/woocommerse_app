import 'package:flutter/material.dart';
import 'package:dunn_oil/models/payment_method.dart';

class PaymentMethodListItem extends StatelessWidget {
  PaymentMethod? paymentMethod;
  PaymentMethodListItem({super.key, this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      focusColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        if (paymentMethod?.isRouteRedirect ?? false) {
          Navigator.of(context).pushNamed(paymentMethod?.route ?? '');
        } else {
          paymentMethod?.onTap!();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: AssetImage(paymentMethod?.logo ?? ''),
                      fit: BoxFit.fill)),
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paymentMethod?.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      paymentMethod?.description ?? '',
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 2,
                    ),
                  ],
                )),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: Theme.of(context).focusColor,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
