import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/modules/auth/change/change_page.dart';
import 'package:flutter_padrao/app/modules/auth/change/change_store.dart';
import 'package:flutter_padrao/app/modules/auth/forget/forget_page.dart';
import 'package:flutter_padrao/app/modules/auth/forget/forget_store.dart';
import 'package:flutter_padrao/app/modules/auth/login/login_page.dart';
import 'package:flutter_padrao/app/modules/auth/login/login_store.dart';
import 'package:flutter_padrao/app/modules/auth/signup/signup_page.dart';
import 'package:flutter_padrao/app/modules/auth/signup/signup_store.dart';
import 'package:flutter_padrao/app/modules/auth/verify/verify_page.dart';
import 'package:flutter_padrao/app/modules/auth/verify/verify_store.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore(auth: i.get())),
    Bind.lazySingleton((i) => SignupStore()),
    Bind.lazySingleton((i) => VerifyStore()),
    Bind.lazySingleton((i) => ForgetStore()),
    Bind.lazySingleton((i) => ChangeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('', child:  (context, args) => const LoginPage(), transition: TransitionType.scale),
    ChildRoute('signup', child:  (context, args) => const SignupPage(), transition: TransitionType.leftToRightWithFade),
    ChildRoute('verify', child:  (context, args) => const VerifyPage(), transition: TransitionType.defaultTransition),
    ChildRoute('forget', child:  (context, args) => const ForgetPage(), transition: TransitionType.leftToRight),
    ChildRoute('change', child:  (context, args) => const ChangePage(), transition: TransitionType.defaultTransition),

  ];

}