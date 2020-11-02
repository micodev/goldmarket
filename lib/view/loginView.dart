import 'package:flutter/material.dart';
import 'package:goldmarket/constants/constants.dart';
import 'package:goldmarket/model/service/locator.dart';
import 'package:goldmarket/model/service/nav_services/navigationService.dart';
import 'package:goldmarket/provider/userProvider.dart';

import 'components/customTextField.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset("images/loginHeader.png").image)),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Flexible(
                        child: Text(
                      "قم بالأنضمام لمجتمع سوق الذهب الآن وتمتع بتصفح و شراء ممتع و آمن..",
                      style: TextStyle(fontSize: 19),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              text: username,
              hintText: "أدخل الأسم التعريفي",
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              text: password,
              hintText: "أدخل الرمز السري",
              isPassword: true,
            ),
            SizedBox(
              height: 20,
            ),
            if (!context.watch<UserProvider>().isloginUserLoading)
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            color: primaryColor,
                            onPressed: () {
                              context
                                  .read<UserProvider>()
                                  .loginUser(username.text, password.text);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "تسجيل دخول",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewPadding.bottom))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlineButton(
                            borderSide: BorderSide(color: primaryColor),
                            onPressed: () {
                              context
                                  .read<UserProvider>()
                                  .userChange(UserStatus.Guest);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "تخطي تسجيل الدخول",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewPadding.bottom))
                      ],
                    ),
                  ),
                ],
              )
            else
              Container(
                padding: EdgeInsets.all(5),
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
          ],
        ),
      )),
    );
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = locator<NavigationService>().navigatorKey.currentContext;
      if (context.read<UserProvider>().userStatus == UserStatus.Error) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("هناك خطأ في المدخلات")));
        context.read<UserProvider>().userStatus = (UserStatus.Initialize);
      }
    });

    super.didChangeDependencies();
  }
}
