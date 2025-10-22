import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import '../bloc/auth_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController;
  late final _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text = 'user@example.com';
    _passwordController.text = 'password123456';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthEvent.login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (token) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login successful!')),
              );
              // TODO: Navigate to home
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: AppColors.error,
                ),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacingResponsive.paddingLG),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // App logo or icon
                      Icon(
                        Icons.lock_outline,
                        size: context.r(80),
                        color: AppColors.primary,
                      ),
                      SizedBox(height: AppSpacingResponsive.lg),

                      // Title
                      Text(
                        'Welcome Back',
                        style: AppTypographyResponsive.displaySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacingResponsive.xs),

                      // Subtitle
                      Text(
                        'Sign in to continue',
                        style: AppTypographyResponsive.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacingResponsive.xxl),

                      // Email field
                      AppTextField(
                        controller: _emailController,
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        enabled: !isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSpacingResponsive.md),

                      // Password field
                      AppTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                        enabled: !isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppSpacingResponsive.xl),

                      // Login button
                      AppButton(
                        label: 'Login',
                        variant: AppButtonVariant.primary,
                        backgroundColor: context.colorScheme.primary,
                        foregroundColor: context.colorScheme.onPrimary,
                        onPressed: isLoading ? null : _onLoginPressed,
                        isLoading: isLoading,
                        isFullWidth: true,
                        icon: Icons.login,
                      ),
                      SizedBox(height: AppSpacingResponsive.md),

                      // Forgot password
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                // TODO: Navigate to forgot password
                              },
                        child: Text(
                          'Forgot Password?',
                          style: AppTypographyResponsive.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
