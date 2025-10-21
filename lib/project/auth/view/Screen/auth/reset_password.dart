import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luby2/core/localization/l10n_ext.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../cubit/auth_cubit.dart';
import '../splash/splash_screens.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController(), _confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true, _obscureConfirmPassword = true, _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().resetPassword(widget.email, _newPasswordController.text);
      setState(() => _isLoading = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.resetPasswordStatus == Status.loading) {
          _isLoading = true;
        } else if (state.resetPasswordStatus == Status.success) {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreens()));
        } else if (state.resetPasswordStatus == Status.error) {
          _isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msg)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text(context.l10n.resetPassword)),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _obscureNewPassword,
                    decoration: InputDecoration(
                      labelText: context.l10n.newPasswordLabel,
                      suffixIcon: IconButton(
                        icon: Icon(_obscureNewPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.pleaseEnterNewPassword;
                      }
                      if (value.length < 6) {
                        return context.l10n.passwordTooShort;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: context.l10n.confirmNewPasswordLabel,
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.fillAllFields;
                      }
                      if (value != _newPasswordController.text) {
                        return context.l10n.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _isLoading ? null : _resetPassword(),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                              : Text(context.l10n.resetPassword),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
