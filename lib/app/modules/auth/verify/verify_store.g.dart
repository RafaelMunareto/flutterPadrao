// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VerifyStore on _VerifyStoreBase, Store {
  final _$msgEmailVerifyAtom = Atom(name: '_VerifyStoreBase.msgEmailVerify');

  @override
  String get msgEmailVerify {
    _$msgEmailVerifyAtom.reportRead();
    return super.msgEmailVerify;
  }

  @override
  set msgEmailVerify(String value) {
    _$msgEmailVerifyAtom.reportWrite(value, super.msgEmailVerify, () {
      super.msgEmailVerify = value;
    });
  }

  final _$tipoAtom = Atom(name: '_VerifyStoreBase.tipo');

  @override
  String get tipo {
    _$tipoAtom.reportRead();
    return super.tipo;
  }

  @override
  set tipo(String value) {
    _$tipoAtom.reportWrite(value, super.tipo, () {
      super.tipo = value;
    });
  }

  final _$_VerifyStoreBaseActionController =
      ActionController(name: '_VerifyStoreBase');

  @override
  dynamic verificaTipo() {
    final _$actionInfo = _$_VerifyStoreBaseActionController.startAction(
        name: '_VerifyStoreBase.verificaTipo');
    try {
      return super.verificaTipo();
    } finally {
      _$_VerifyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic emailVerify() {
    final _$actionInfo = _$_VerifyStoreBaseActionController.startAction(
        name: '_VerifyStoreBase.emailVerify');
    try {
      return super.emailVerify();
    } finally {
      _$_VerifyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
msgEmailVerify: ${msgEmailVerify},
tipo: ${tipo}
    ''';
  }
}
