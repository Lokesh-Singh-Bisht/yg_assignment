import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController phoneExtensionController;

  const PhoneInputField({
    super.key,
    required this.phoneController,
    required this.phoneExtensionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Enter your mobile number",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // Country Code Field
            SizedBox(
              width: 80,
              child: TextField(
                controller: phoneExtensionController,
                keyboardType: TextInputType.phone,
                maxLength: 4,
                decoration: InputDecoration(
                  prefixText: '+',
                  counterText: '',
                  labelText: 'Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Phone Number Field
            Expanded(
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  counterText: '',
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
