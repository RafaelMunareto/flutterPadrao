import 'package:flutter/material.dart';
import 'package:flutter_padrao/app/shared/utils/error_pt_br.dart';

class SnackbarCustom  {
  createSnackBar(message, cor, context) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: cor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  createSnackBarErrorFirebase(message, cor, context) {
    final snackBar = SnackBar(content: Text(ErrorPtBr().verificaCodeErro(message)), backgroundColor: cor);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}