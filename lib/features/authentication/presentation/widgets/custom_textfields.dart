import 'package:flutter/material.dart';

import '../../../../../theme/text_scheme.dart';
import '../../../../core/utils/validation.dart';

// SECTION: AUTH PAGE Components
/* -------------------------------------------------------------------------- */

// Component: Email Text Form Field
class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        labelText: 'Email',
        labelStyle: bodyDefault(textTheme).copyWith(
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      autofillHints: const [AutofillHints.email],
      // onFieldSubmitted: (_) => null,
      validator: Validator.validateEmail,
    );
  }
}

// Component: Password Text Form Field
class PassWordTextFormField extends StatefulWidget {
  const PassWordTextFormField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PassWordTextFormField> createState() => _PassWordTextFormFieldState();
}

class _PassWordTextFormFieldState extends State<PassWordTextFormField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      autocorrect: false,
      textInputAction: TextInputAction.done,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility_off_outlined
                : Icons.remove_red_eye_outlined,
          ),
          onPressed: () => _togglePasswordVisibility(),
        ),
        labelText: 'Password',
        labelStyle: bodyDefault(textTheme).copyWith(
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: !_isPasswordVisible,
      validator: (password) {
        if (password == null || password.isEmpty) {
          return 'Please enter a password';
        }
        if (password.length < 8) {
          return 'Password must be at least 8 characters long';
        }
        return null;
      },
    );
  }
}

// Component: Normal Text Form Field
class NormalTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String errorText;
  final Icon? prefixIcon;
  final bool needsValidation;
  const NormalTextFormField({
    super.key,
    required this.controller,
    required this.needsValidation,
    required this.labelText,
    required this.errorText,
    this.prefixIcon,
  });

  @override
  State<NormalTextFormField> createState() => _NormalTextFormFieldState();
}

class _NormalTextFormFieldState extends State<NormalTextFormField> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      textCapitalization: TextCapitalization.words,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        labelText: widget.labelText,
        labelStyle: bodyDefault(textTheme).copyWith(
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: widget.needsValidation
          ? (value) {
              if (value == null || value.isEmpty) {
                return widget.errorText;
              }
              return null;
            }
          : null,
    );
  }
}

/* -------------------------------------------------------------------------- */
// !SECTION: Components
