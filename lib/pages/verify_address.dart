import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommerse_app/models/customer_detail_model.dart';
import 'package:woocommerse_app/pages/checkout_base.dart';
import 'package:woocommerse_app/pages/payment_screen.dart';
import 'package:woocommerse_app/provider/cart_provider.dart';
import 'package:woocommerse_app/utils/form_helper.dart';

class VerifyAddress extends CheckoutBasePage {
  const VerifyAddress({super.key});

  @override
  State<VerifyAddress> createState() => _VerifyAddressState();
}

class _VerifyAddressState extends CheckoutBasePageState<VerifyAddress> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  CustomerDetailModel customerModel = CustomerDetailModel();

  @override
  void initState() {
    currentPage = 0;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.fetchShippingDetails().then((_) {
      if (cartProvider.customerDetailModel != null) {
        setState(() {
          customerModel = cartProvider.customerDetailModel!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget pageUI() {
    return Consumer<CartProvider>(
      builder: (context, customerProvider, child) {
        return _formUI(context, customerProvider);
      },
    );
  }

  Widget _formUI(BuildContext context, CartProvider customerProvider) {
    return SingleChildScrollView(
      child: Form(
        key: globalKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHelper.fieldLabel("First Name*"),
                            FormHelper.textInput(
                              context,
                              customerModel.firstName ?? "",
                              (String value) {
                                setState(() {
                                  customerModel.firstName = value;
                                });
                              },
                              onValidate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please enter First Name";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHelper.fieldLabel("Last Name*"),
                            FormHelper.textInput(
                              context,
                              customerModel.lastName ?? "",
                              (String value) {
                                setState(() {
                                  customerModel.lastName = value;
                                });
                              },
                              onValidate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please enter Last Name";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  FormHelper.fieldLabel("Address*"),
                  FormHelper.textInput(
                    context,
                    customerModel.shipping?.address1 ?? "",
                    (value) {
                      if (customerModel.shipping == null) {
                        customerModel.shipping = Shipping();
                      }
                      customerModel.shipping?.address1 = value;
                    },
                    onValidate: (value) {
                      if (value.toString().isEmpty) {
                        return "Please enter Address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  FormHelper.fieldLabel("Apartment, suite, etc.*"),
                  FormHelper.textInput(
                    context,
                    customerModel.shipping?.address2 ?? "",
                    (value) {
                      if (customerModel.shipping == null) {
                        customerModel.shipping = Shipping();
                      }
                      customerModel.shipping?.address2 = value;
                    },
                    onValidate: (value) => null,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHelper.fieldLabel("Country*"),
                            FormHelper.textInput(
                              context,
                              customerModel.shipping?.country ?? "",
                              (value) {
                                if (customerModel.shipping == null) {
                                  customerModel.shipping = Shipping();
                                }
                                customerModel.shipping?.country = value;
                              },
                              onValidate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please enter Country";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHelper.fieldLabel("State*"),
                            FormHelper.textInput(
                              context,
                              customerModel.shipping?.state ?? "",
                              (value) {
                                if (customerModel.shipping == null) {
                                  customerModel.shipping = Shipping();
                                }
                                customerModel.shipping?.state = value;
                              },
                              onValidate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please enter State";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHelper.fieldLabel("City*"),
                            FormHelper.textInput(
                              context,
                              customerModel.shipping?.city ?? "",
                              (value) {
                                if (customerModel.shipping == null) {
                                  customerModel.shipping = Shipping();
                                }
                                customerModel.shipping?.city = value;
                              },
                              onValidate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please enter City";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHelper.fieldLabel("Postcode*"),
                            FormHelper.textInput(
                              context,
                              customerModel.shipping?.postcode ?? "",
                              (value) {
                                if (customerModel.shipping == null) {
                                  customerModel.shipping = Shipping();
                                }
                                customerModel.shipping?.postcode = value;
                              },
                              onValidate: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please enter Postcode";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: FormHelper.saveButton(
                      "Next",
                      () {
                        if (validateAndSave()) {
                          print("First Name: ${customerModel.firstName}");
                          print("Last Name: ${customerModel.lastName}");
                          customerProvider.updateCustomerDetails(customerModel);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PaymentMethodsWidget(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
