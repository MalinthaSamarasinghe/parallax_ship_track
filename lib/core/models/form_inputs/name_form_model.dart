import 'package:formz/formz.dart';
import '../../other/regular_expressions.dart';

/// Validation errors for the [Name] [FormzInput].
enum NameValidationErrorType {
  /// Generic invalid error.
  empty,
  invalidCharacters,
  invalidLength
}

class NameValidationError {
  final NameValidationErrorType? type;
  final String? message;

  NameValidationError({this.type, this.message});
}

/// Form input for a name input.
class NameFormzModel extends FormzInput<String, NameValidationError> {
  const NameFormzModel.pure() : super.pure('');

  const NameFormzModel.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if(value.isEmpty) {
      return NameValidationError(
        type: NameValidationErrorType.empty,
        message: "The name shouldn't be empty",
      );
    }
    if(value.length < 3) {
      return NameValidationError(
        type: NameValidationErrorType.invalidLength,
        message: "The name should contain at least 3 characters",
      );
    }
    if(!RegularExpressions.fullName.hasMatch(value)) {
      return NameValidationError(
        type: NameValidationErrorType.invalidCharacters,
        message: "The name shouldn't contain special characters & numbers",
      );
    }
    return null;
  }
}