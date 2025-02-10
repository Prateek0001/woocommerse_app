import 'package:flutter/material.dart';
import 'package:dunn_oil/api_service.dart';
import 'package:dunn_oil/config.dart';
import 'package:dunn_oil/models/customer.dart';
import 'package:dunn_oil/utils/ProgressHUD.dart';
import 'package:dunn_oil/utils/form_helper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  ApiService? apiService;
  CustomerModel? model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = new ApiService();
    model = new CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: true,
        title: Text("Sign Up"),
      ),
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        child: new Form(
          key: globalKey,
          child: _formUI(),
        ),
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("First Name"),
                FormHelper.textInput(
                    context,
                    model?.firstName ?? '',
                    (value) => {
                          this.model?.firstName = value,
                        }, onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return "Please enter First Name";
                  }
                  return null;
                }),
                FormHelper.fieldLabel("Last Name"),
                FormHelper.textInput(
                    context,
                    model?.lastName ?? '',
                    (value) => {
                          this.model?.lastName = value,
                        }, onValidate: (value) {
                  return null;
                }),
                FormHelper.fieldLabel("Email Id"),
                FormHelper.textInput(
                    context,
                    model?.email ?? '',
                    (value) => {
                          this.model?.email = value,
                        }, onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return "Please enter Email Id";
                  }
                  return null;
                }),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                    context,
                    model?.password ?? '',
                    (value) => {
                          this.model?.password = value,
                        }, onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return "Please enter Password";
                  }
                  return null;
                },
                    obscureText: hidePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FormHelper.saveButton("Register", () {
                    if (validateAndSave()) {
                      print(model?.toJson());
                      setState(() {
                        isApiCallProcess = true;
                      });

                      apiService?.createCustomer(model).then((ret) {
                        setState(() {
                          isApiCallProcess = false;
                        });

                        if (ret) {
                          FormHelper.showMessage(context, Config.appName,
                              "Registration Successfull", "Ok", () {
                            Navigator.of(context).pop();
                          });
                        } else {
                          FormHelper.showMessage(context, Config.appName,
                              "Email Id already registered", "Ok", () {
                            Navigator.of(context).pop();
                          });
                        }
                      });
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
