import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:simple_iam/widgets/form/field_label.dart';

class PasswordFormField extends HookWidget {
  final Key? passwordFieldKey;
  final TextEditingController passwordController;
  final FormFieldValidator<String?> validatePassword;

  const PasswordFormField({
    super.key,
    this.passwordFieldKey,
    required this.passwordController,
    required this.validatePassword,
  });

  @override
  Widget build(BuildContext context) {
    final isFieldObscured = useState(true);
    final isShowPasswordIcon = useState(false);

    return Stack(
      children: [
        TextFormField(
          key: passwordFieldKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            label: FieldLabel(
              label: Text('Password'),
              isRequired: true,
            ),
          ),
          obscureText: isFieldObscured.value,
          autocorrect: false,
          enableSuggestions: false,
          controller: passwordController,
          validator: validatePassword,
          onTap: () => isShowPasswordIcon.value = true,
          onTapOutside: (_) => isShowPasswordIcon.value = false,
        ),
        Positioned.fill(
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: GestureDetector(
              onTap: () => isFieldObscured.value = !isFieldObscured.value,
              child: Icon(
                isFieldObscured.value
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
