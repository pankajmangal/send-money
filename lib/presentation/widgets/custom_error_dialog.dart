import 'package:flutter/widgets.dart';
import 'package:send_money/presentation/widgets/generic_error_dialog.dart';

Future<void> showError(
    {required BuildContext context, required String error}) {
  return showGenericDialogue<bool>(
      context: context,
      title: "Error!",
      content: error,
      optionBuilder: () {
        return {'OK': true};
      });
}