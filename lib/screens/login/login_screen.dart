import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yg_assignment/routes/app_routes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';

import 'widgets/phone_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final phoneExtensionController = TextEditingController();
  final ValueNotifier<bool> isPhoneValid = ValueNotifier(false);

  @override
  void initState() {
    phoneExtensionController.text = "91"; // Default to India
    phoneController.addListener(validatePhoneInput);
    super.initState();
  }

  void validatePhoneInput() {
    final isValid =
        phoneController.text.trim().length == 10 &&
        phoneExtensionController.text.trim().isNotEmpty;
    isPhoneValid.value = isValid;
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneExtensionController.dispose();
    isPhoneValid.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                AppRoutes.router.go('/home');
              } else if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is AuthCodeSent) {
                AppRoutes.router.push('/verify-otp', extra: state.phoneNumber);
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("🔐 ", style: TextStyle(fontSize: 40)),
                          RichText(
                            text: TextSpan(
                              style: Theme.of(
                                context,
                              ).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              children: [
                                TextSpan(text: "Login\n"),
                                TextSpan(
                                  text: "to your Account",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      PhoneInputField(
                        phoneController: phoneController,
                        phoneExtensionController: phoneExtensionController,
                      ),
                      const SizedBox(height: 24),
                      if (state is AuthLoading)
                        const CircularProgressIndicator()
                      else
                        ValueListenableBuilder<bool>(
                          valueListenable: isPhoneValid,
                          builder: (context, valid, _) {
                            return ElevatedButton.icon(
                              iconAlignment: IconAlignment.end,
                              icon: const Icon(Icons.arrow_forward),
                              onPressed:
                                  valid
                                      ? () {
                                        FocusScope.of(context).unfocus();
                                        final phone =
                                            "+${phoneExtensionController.text.trim()}${phoneController.text.trim()}";
                                        context.read<AuthBloc>().add(
                                          AuthPhoneNumberSubmitted(phone),
                                        );
                                      }
                                      : null,
                              label: Text("Send OTP"),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 32,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
