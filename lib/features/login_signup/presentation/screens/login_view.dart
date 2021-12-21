import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puvts_driver/core/constants/puvts_colors.dart';
import 'package:puvts_driver/core/widgets/bottom_nav.dart';
import 'package:puvts_driver/core/widgets/keyboard_dismisser.dart';
import 'package:puvts_driver/core/widgets/puvts_button.dart';
import 'package:puvts_driver/core/widgets/puvts_textfield.dart';
import 'package:puvts_driver/features/login_signup/domain/bloc/login_signup_bloc.dart';
import 'package:puvts_driver/features/login_signup/domain/bloc/login_signup_state.dart';
import 'package:puvts_driver/generated/assets.gen.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginSignupBloc>(
      create: (_) => LoginSignupBloc(),
      child: BlocConsumer<LoginSignupBloc, LoginSignupState>(
        listener: (BuildContext context, LoginSignupState state) async {
          if ((state.finished || state.isCached) &&
              !state.isLoading &&
              !state.hasError) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => BottomNav()));
          }

          if (!state.isDriver) {
            showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(top: 25, bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'You need to login as Passenger',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: PuvtsButton(
                          height: 40,
                          buttonColor: puvtsBlue,
                          onPressed: () => Navigator.pop(context),
                          text: 'Try Again',
                          textSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state.hasError) {
            showDialog<String>(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) => AlertDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 24)
                    .copyWith(top: 25, bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Username or Password is Incorrect',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: PuvtsButton(
                          height: 40,
                          buttonColor: puvtsBlue,
                          onPressed: () => Navigator.pop(context),
                          text: 'Try Again',
                          textSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        builder: (BuildContext context, LoginSignupState state) {
          return KeyboardDismisser(
            child: Scaffold(
              backgroundColor: puvtsBlue,
              body: Container(
                margin: EdgeInsets.only(top: 40),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: EdgeInsets.all(30),
                        child: Image.asset(
                          Assets.images.logoPin.path,
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'PUVTS DRIVER APP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: puvtsWhite,
                        ),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: puvtsWhite,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 30),
                      PuvtsTextfield(
                        labelText: 'Email',
                        textStyle: TextStyle(
                            color: puvtsWhite.withOpacity(0.8), fontSize: 20),
                        controller: usernameController,
                      ),
                      const SizedBox(height: 15),
                      PuvtsTextfield(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () => context
                              .read<LoginSignupBloc>()
                              .showHidePassword(),
                          color: puvtsWhite,
                          icon: Icon(
                            state.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                          ),
                        ),
                        textStyle: TextStyle(
                            color: puvtsWhite.withOpacity(0.8), fontSize: 20),
                        controller: passwordController,
                        obscureText: state.obscurePassword,
                      ),
                      const SizedBox(height: 150),
                      PuvtsButton(
                        width: 200,
                        height: 60,
                        buttonColor: puvtsBlue,
                        onPressed: () => context.read<LoginSignupBloc>().login(
                              email: usernameController.text,
                              password: passwordController.text,
                            ),
                        icon: state.isLoading
                            ? CircularProgressIndicator(color: puvtsWhite)
                            : Icon(
                                Icons.arrow_forward_ios,
                                color: puvtsWhite,
                              ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
