import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/constants/constance.dart';
import '../../../../../../config/widget/widget.dart';
import '../../../../../../locator.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../Home/ui/hom_screen.dart';
import '../../../../models/user.dart';
import '../../../cubit/auth_cubit.dart';
import 'reset_password.dart';

class ConfirmOtpScreen extends StatefulWidget {
  const ConfirmOtpScreen({super.key, this.user, required this.willSignup, required this.email});
  final UserModel? user;
  final String email;
  final bool willSignup;
  @override
  State<ConfirmOtpScreen> createState() => _ConfirmOtpScreenState();
}

class _ConfirmOtpScreenState extends State<ConfirmOtpScreen> with TickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;
  late AnimationController _animationController;
  late AnimationController _fadeController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _fadeController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.elasticOut));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));

    _animationController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fadeController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _confirmOtp() async {
    _errorText = null;
    setState(() => _isLoading = true);
    if (_otpController.text.isEmpty || _otpController.text.length < 4) {
      _errorText = 'Please enter a valid 4-character code';
      setState(() => _isLoading = false);
      return;
    }
    context.read<AuthCubit>().confirmOtp(widget.email, _otpController.text, widget.willSignup);
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<AuthCubit, AuthState>(
    listener: (context, state) {
      switch (state.confirmOtpStatus) {
        case Status.error:
          showToast(text: state.msg, stute: ToustStute.error);
          break;
        case Status.success:
          if (widget.willSignup) {
            getIt.get<AuthCubit>().signup(widget.user!);
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(email: widget.email)));
          }
          break;
        default:
          break;
      }
      switch (state.signupStatus) {
        case Status.initial:
          break;
        case Status.error:
          showToast(text: state.msg, stute: ToustStute.error);
          break;
        case Status.success:
          getIt.get<HomeCubit>().updateCurrentScreenIndex(0);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));

          break;
        default:
          break;
      }
    },
    builder: (context, state) {
      if (state.confirmOtpStatus == Status.loading || state.signupStatus == Status.loading) {
        _isLoading = true;
      } else {
        _isLoading = false;
      }
      return Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Header Section with Animation
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            // Back Button
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 10, offset: const Offset(0, 4)),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF64748B), size: 20),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Modern OTP Icon
                            AnimatedBuilder(
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF10B981).withAlpha(75),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(Icons.lock_outline, size: 60, color: Colors.white),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(height: 32),

                            // Title
                            const Text(
                              'Enter 6-Character Code',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Subtitle with email
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(fontSize: 16, color: Color(0xFF64748B), height: 1.5),
                                children: [
                                  const TextSpan(text: 'We\'ve sent a 6-character code to\n'),
                                  TextSpan(
                                    text: widget.email,
                                    style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),

                  // Form Section with Animation
                  AnimatedBuilder(
                    animation: _slideAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: Column(
                          children: [
                            // OTP Input Field
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 10, offset: const Offset(0, 4)),
                                ],
                              ),
                              child: TextFormField(
                                controller: _otpController,
                                maxLength: 6,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.characters,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1E293B),
                                  letterSpacing: 8,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Enter 6-character code',
                                  labelStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
                                  hintText: 'ABC123',
                                  hintStyle: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 24, letterSpacing: 8),
                                  prefixIcon: Container(
                                    margin: const EdgeInsets.all(12),
                                    child: Icon(Icons.security, color: const Color(0xFF64748B), size: 24),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  counterText: '',
                                  errorText: _errorText,
                                  errorStyle: const TextStyle(color: Color(0xFFEF4444), fontSize: 14),
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Submit Button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _confirmOtp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF10B981),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: const Color(0xFF10B981).withAlpha(76),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child:
                                    _isLoading
                                        ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                        )
                                        : const Text(
                                          'Verify Code',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                                        ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Additional Info
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline, color: const Color(0xFF64748B), size: 20),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'The code will expire in 2 minutes. Check your spam folder if you don\'t receive it.',
                                      style: TextStyle(fontSize: 14, color: const Color(0xFF64748B), height: 1.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Resend Code Option
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Didn\'t receive the code? ',
                                  style: TextStyle(fontSize: 14, color: const Color(0xFF64748B)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Add resend logic here
                                    showToast(text: 'Resend functionality coming soon', stute: ToustStute.success);
                                  },
                                  child: Text(
                                    'Resend',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF10B981),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
