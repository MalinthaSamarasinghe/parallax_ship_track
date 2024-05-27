import 'package:formz/formz.dart';
import '../../other/regular_expressions.dart';

/// Validation errors for the [Password] [FormzInput].
enum PasswordValidationErrorType {
  /// Generic invalid error.
  empty,
  invalid,
}

class PasswordValidationError {
  final PasswordValidationErrorType type;
  final String message;

  PasswordValidationError({required this.type, required this.message});
}

/// Form input for a password input.
class PasswordFormzModel extends FormzInput<PasswordParameters, PasswordValidationError> {
  const PasswordFormzModel.pure(super.value) : super.pure();

  const PasswordFormzModel.dirty(super.value) : super.dirty();

  @override
  PasswordValidationError? validator(PasswordParameters value) {
    if (value.isPasswordField && value.password == '') {
      return PasswordValidationError(
        type: PasswordValidationErrorType.empty,
        message: "The password shouldn't be empty",
      );
    } else if (value.isPasswordField == false && value.password == '') {
      return PasswordValidationError(
        type: PasswordValidationErrorType.invalid,
        message: "The confirm password shouldn't be empty",
      );
    } else if (value.isPasswordField == false && value.confirmPassword != value.password) {
      return PasswordValidationError(
        type: PasswordValidationErrorType.invalid,
        message: "The password doesn't match",
      );
    }

    if (value.isPasswordField && !RegularExpressions.passwordCharacters.hasMatch(value.password)) {
      return PasswordValidationError(
        type: PasswordValidationErrorType.invalid,
        message: "The password should contain at least 8 characters",
      );
    }

    if (value.isPasswordField && !RegularExpressions.passwordUppercase.hasMatch(value.password)) {
      return PasswordValidationError(
        type: PasswordValidationErrorType.invalid,
        message: "The password should contain at least 1 uppercase letter",
      );
    }

    if (value.isPasswordField && !RegularExpressions.passwordLowercase.hasMatch(value.password)) {
      return PasswordValidationError(
        type: PasswordValidationErrorType.invalid,
        message: "The password should contain at least 1 lowercase letter",
      );
    }

    if (value.isPasswordField && !RegularExpressions.passwordSpecial.hasMatch(value.password)) {
      return PasswordValidationError(
        type: PasswordValidationErrorType.invalid,
        message: "The password should contain at least 1 special character",
      );
    }

    return null;
  }
}

class PasswordParameters {
  final bool isPasswordField;
  final String password;
  final String confirmPassword;

  const PasswordParameters({
    this.isPasswordField = true,
    this.password = '',
    this.confirmPassword = '',
  });
}
