import 'package:formz/formz.dart';
import '../../other/regular_expressions.dart';

/// Validation errors for the [Email] [FormzInput].
enum EmailValidationErrorType {
  /// Generic invalid error.
  empty,
  invalid,
}

class EmailValidationError {
  final EmailValidationErrorType type;
  final String message;

  EmailValidationError({required this.type, required this.message});
}

/// Form input for an email input.
class EmailFormzModel extends FormzInput<String, EmailValidationError> {
  const EmailFormzModel.pure() : super.pure('');

  const EmailFormzModel.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError(
        type: EmailValidationErrorType.empty,
        message: "The email shouldn't be empty",
      );
    }
    if (!RegularExpressions.email.hasMatch(value)) {
      return EmailValidationError(
        type: EmailValidationErrorType.invalid,
        message: "Please enter a valid email",
      );
    }
    return null;
  }
}
