import 'dart:html';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = Modular.get();
  final FirebaseFirestore db = Modular.get();
  final FirebaseDynamicLinks fdl = Modular.get();

  @override
  Future getEmailPasswordLogin(email, password) async {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future getFacebookLogin() {
    // TODO: implement getFacebookLogin
    throw UnimplementedError();
  }

  @override
  Future<String> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  getGoogleLogin() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User? user = (await auth.signInWithCredential(credential)).user;
    return user;
  }

  @override
  getUser() {
    return auth.currentUser;
  }

  @override
  Future getLogout() {
    return auth.signOut();
  }

  @override
  Future createUserSendEmailLink(name, email, password) async {
    return auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) async {
      User? user = FirebaseAuth.instance.currentUser;
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://flutterpadrao.firebaseapp.com',
        handleCodeInApp: true,
      );
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification(actionCodeSettings);
      }
      firebaseUser.user!.updateDisplayName(name).then((value) {
        db.collection('usuarios').doc(auth.currentUser!.uid).set({
          "name": name,
          "email": email,
          "urlImage":
              'https://firebasestorage.googleapis.com/v0/b/flutterpadrao.appspot.com/o/perfil%2Fbancario1.png?alt=media&token=ff79a9b9-7f1e-4e53-98c7-824324f74935',
          "verificado": false
        });
      });
    });
  }

  @override
  Future getGrupoEmail() {
    return db.collection('grupoEmail').get();
  }

  @override
  Future<String?> emailVerify() async {
    if (!kIsWeb) {
      final PendingDynamicLinkData? data = await fdl.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        var actionCode = deepLink.queryParameters['oobCode'];
        var tipo = deepLink.queryParameters['mode'];
        try {
          if (actionCode != null && tipo == 'verifyEmail') {
            await auth.applyActionCode(actionCode).then((value) {
              auth.currentUser?.reload();
              changeUserVerificacao();
              return 'Email validado com Sucesso!';
            });
          }
        } on FirebaseAuthException catch (e) {
          return ErrorPtBr().verificaCodeErro('auth/' + e.code);
        }
      }
    } else {
      var uri = Uri.dataFromString(window.location.href);
      Map<String, String> params =
          uri.queryParameters; // query parameters automatically populated
      var actionCode = params['oobCode'];
      var tipo = params['mode'];
      try {
        if (actionCode != null && tipo == 'verifyEmail') {
          await auth.checkActionCode(actionCode).then((value) {
            auth.currentUser?.reload();
            changeUserVerificacao();
            return 'Email validado com Sucesso!';
          });
        }
      } on FirebaseAuthException catch (e) {
         return ErrorPtBr().verificaCodeErro('auth/' + e.code);
      }
    }
  }

  @override
  Future createUserEmailPassword(name, email, password) {
    return auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((firebaseUser) async {
      firebaseUser.user!.updateDisplayName(name).then((value) {
        changeUserVerificacao();
      });
    });
  }

  @override
  Future sendChangePasswordEmail(email) {
    return auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future changeResetPassword(password, code) async {
    if (!kIsWeb) {
      final PendingDynamicLinkData? data = await fdl.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        var actionCode = deepLink.queryParameters['oobCode'];
        var tipo = deepLink.queryParameters['mode'];
        try {
          if (actionCode != null && tipo == 'resetPassword') {
            await auth.applyActionCode(actionCode).then((value) {
              auth.currentUser?.reload();
              return auth.confirmPasswordReset(
                  code: actionCode, newPassword: password);
            });
          }
        } on FirebaseAuthException catch (e) {
          return ErrorPtBr().verificaCodeErro('auth/' + e.code);
        }
        return 'Código Inválido';
      }
    }else{
      var uri = Uri.dataFromString(window.location.href);
      Map<String, String> params =
          uri.queryParameters; // query parameters automatically populated
      auth.confirmPasswordReset(
          code: code, newPassword: password);
      getUser().reload();

    }
  }

  changeUserVerificacao()
  {
    db.
    collection('usuarios').doc(getUser().uid).update({
      "name": getUser().displayName,
      "email": getUser().email,
      "urlImage":
      'https://firebasestorage.googleapis.com/v0/b/flutterpadrao.appspot.com/o/perfil%2Fbancario1.png?alt=media&token=ff79a9b9-7f1e-4e53-98c7-824324f74935',
      "verificado": true
    });
  }
}
