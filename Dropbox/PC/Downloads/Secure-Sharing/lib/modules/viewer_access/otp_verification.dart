import 'package:flutter/material.dart';

class OTPVerificationPage extends StatelessWidget {
  final void Function(String) onSubmit;

  const OTPVerificationPage({required this.onSubmit, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "OTP"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => onSubmit(controller.text),
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
