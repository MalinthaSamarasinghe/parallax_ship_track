import 'package:formz/formz.dart';

/// Validation errors for the [CommonField] [FormzInput].
enum CommonValidationErrorType {
  /// Generic invalid error.
  empty,
  invalid,
}

class CommonValidationError {
  final CommonValidationErrorType type;
  final String message;

  CommonValidationError({required this.type, required this.message});
}

/// Form input for a common input.
class CommonFormzModel extends FormzInput<String, CommonValidationError> {
  const CommonFormzModel.pure() : super.pure('');

  const CommonFormzModel.dirty(super.value) : super.dirty();

  @override
  CommonValidationError? validator(String value) {
    if (value.isEmpty) {
      return CommonValidationError(
        type: CommonValidationErrorType.empty,
        message: "This field shouldn't be empty",
      );
    }
    return null;
  }
}
