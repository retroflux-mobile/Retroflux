import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:retroflux/widgets/ImagePickerWidget.dart';

class SignupQuestion extends StatefulWidget {
  static const String routeName = '/signup_question';

  final TextEditingController textController;
  final String question;
  final String hint;
  final bool isAvatar;
  final bool isNumber;
  final Function validate;

  SignupQuestion(
    this.question,
    this.hint,
    this.textController,
    this.validate, {
    Key? key,
    required this.isAvatar,
    required this.isNumber,
  });

  @override
  State<SignupQuestion> createState() => _SignupQuestionState();
}

class _SignupQuestionState extends State<SignupQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Text(
            widget.question,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(
            height: 50,
          ),
          widget.isAvatar
              ? ImagePickerWidget(widget.textController)
              : TextField(
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: widget.hint,
                    errorText: widget.validate(),
                  ),
                  keyboardType: widget.isNumber
                      ? TextInputType.number
                      : TextInputType.text,
                  controller: widget.textController,
                ),
        ],
      ),
    );
  }
}
