import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpInputField extends StatefulWidget {
  final void Function(String)? onCompleted;

  OtpInputField({super.key, this.onCompleted});

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PinCodeTextField(
          appContext: context,
          length: 6,
          keyboardType: TextInputType.number,
          autoFocus: true,
          useHapticFeedback: true,
          cursorColor: Theme.of(context).colorScheme.primary,
          cursorWidth: 3,
          animationType: AnimationType.fade,
          textStyle: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            fieldHeight: 56,
            fieldWidth: 48,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.grey.shade200,
            selectedFillColor: Colors.grey.shade100,
            activeColor: Theme.of(context).colorScheme.primary,
            selectedColor: Theme.of(context).colorScheme.primary,
            inactiveColor: Colors.grey,
          ),
          animationDuration: const Duration(milliseconds: 200),
          onChanged: (value) {},
          onCompleted: widget.onCompleted,
        ),
      ],
    );
  }
}
