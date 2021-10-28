import 'package:flutter/material.dart';

Future pushToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
}

Future pushAndReplaceToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => widget));
}

Future popAllAndPush(BuildContext context, Widget widget) async {
  await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => widget),
      ModalRoute.withName('/'));
}
