import 'package:flutter/material.dart';
import 'package:dunn_oil/api_service.dart';
import 'package:dunn_oil/config.dart';
import 'package:dunn_oil/utils/ProgressHUD.dart';
import 'package:dunn_oil/utils/form_helper.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? username;
  String? password;
  ApiService? apiService;

  @override
  void initState() {
    apiService = new ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: _uiSetup(context),
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                   Text(
                    Config.appName,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    FormHelper.fieldLabel("Username"),
                    FormHelper.textInput(
                      context,
                      username ?? "",
                      (value) => username = value,
                      onValidate: (value) {
                        if (value.toString().isEmpty) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      prefixIcon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 20),
                    FormHelper.fieldLabel("Password"),
                    FormHelper.textInput(
                      context,
                      password ?? "",
                      (value) => password = value,
                      onValidate: (value) {
                        if (value.toString().isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      obscureText: hidePassword,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                        icon: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: FormHelper.saveButton(
                        "Login",
                        () {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });

                            apiService
                                ?.loginCustomer(username, password)
                                .then((ret) {
                              if (ret != null) {
                                
                                print(ret.data?.token);
                                print(ret.data?.toJson());
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                FormHelper.showMessage(
                                    context,
                                    Config.appName,
                                    "Login Successfull",
                                    "Ok",
                                    () {});
                              } else {
                                FormHelper.showMessage(
                                    context,
                                    Config.appName,
                                    "Invalid Login!!",
                                    "Ok",
                                    () {
                                      Navigator.of(context).pop();
                                    });
                              }
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Don't have an account? Register",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
