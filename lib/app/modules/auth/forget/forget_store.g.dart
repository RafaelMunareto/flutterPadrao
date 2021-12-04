// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ForgetStore on _ForgetStoreBase, Store {
  final _$loadingAtom = Atom(name: '_ForgetStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$msgFirebaseAtom = Atom(name: '_ForgetStoreBase.msgFirebase');

  @override
  String get msgFirebase {
    _$msgFirebaseAtom.reportRead();
    return super.msgFirebase;
  }

  @override
  set msgFirebase(String value) {
    _$msgFirebaseAtom.reportWrite(value, super.msgFirebase, () {
      super.msgFirebase = value;
    });
  }

  final _$checkErrorAtom = Atom(name: '_ForgetStoreBase.checkError');

  @override
  bool get checkError {
    _$checkErrorAtom.reportRead();
    return super.checkError;
  }

  @override
  set checkError(bool value) {
    _$checkErrorAtom.reportWrite(value, super.checkError, () {
      super.checkError = value;
    });
  }

  final _$_ForgetStoreBaseActionController =
      ActionController(name: '_ForgetStoreBase');

  @override
  dynamic submit() {
    final _$actionInfo = _$_ForgetStoreBaseActionController.startAction(
        name: '_ForgetStoreBase.submit');
    try {
      return super.submit();
    } finally {
      _$_ForgetStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
msgFirebase: ${msgFirebase},
checkError: ${checkError}
    ''';
  }
}
