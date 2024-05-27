import 'package:dio/dio.dart';
import '../models/dio_response_model.dart';
import '../network/server_error_data.dart';

/// Throws when there's no shared pref data to fetch
class CacheException implements Exception {}

/// Exception for the HTTP requests from Dio
class ServerException implements Exception {
  late String errorMessage;
  late bool unexpectedError;
  ServerErrorData? data;

  ServerException({required this.errorMessage, required this.unexpectedError});

  /// Constructor for Dio package
  ServerException.fromDioError(DioException dioError) {
    data = ServerErrorData.fromDioError(dioError);
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = "Request to the server was canceled.";
        unexpectedError = false;
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out. Try again or later!";
        unexpectedError = false;
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "Receiving timeout occurred. Try again or later!";
        unexpectedError = false;
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "Request send timed out. Try again or later!";
        unexpectedError = false;
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioError.response);
        break;
      case DioExceptionType.unknown:
        if ((dioError.message ?? '').contains('SocketException')) {
          errorMessage = "Request failed. Make sure your connection has internet access.";
          unexpectedError = false;
          break;
        }
        errorMessage = "Unexpected error occurred.";
        unexpectedError = true;
        break;
      default:
        errorMessage = "Something went wrong!";
        unexpectedError = true;
        break;
    }
  }

  String _handleStatusCode(Response? response) {
    int? statusCode = response?.statusCode;
    switch (statusCode) {
      case 302:
        unexpectedError = true;
        return "Redirection: further action needs to be taken in order to complete the request";
      case 400:
        unexpectedError = true;
        return "Bad request!";
      case 401:
        unexpectedError = false;
        return "Authentication failed. Please log in again!";
      case 403:
        unexpectedError = false;
        return "The authenticated user is not allowed to access the specified API endpoint.";
      case 404:
        unexpectedError = true;
        return "The requested resource does not exist!";
      case 405:
        unexpectedError = true;
        return "Method not allowed. Please check the Allow header for the allowed HTTP methods.";
      case 410:
        unexpectedError = true;
        return "This email is not found!";
      case 411:
        unexpectedError = true;
        return "An error occurred. Please try again later.";
      case 415:
        unexpectedError = true;
        return "Unsupported media type. The requested content type or version number is invalid.";
      case 420:
        unexpectedError = true;
        return "Failed to verify email!";
      case 422:
        unexpectedError = false;
        return _getDataValidationErrorMessage(response) ?? "Data validation failed!";
      case 423:
        unexpectedError = true;
        return "An error occurred. Please try again later.";
      case 429:
        unexpectedError = true;
        return "Too many requests!";
      case 500:
        unexpectedError = true;
        return "Internal server error. Please contact admin!";
      case 433:
        unexpectedError = true;
        return "An error occurred. Please try again later.";
      case 434:
        unexpectedError = true;
        return "An error occurred. Please try again later.";
      default:
        unexpectedError = true;
        return "Oops something went wrong! Error ${statusCode.toString()}";
    }
  }

  /// Generate Validation Errors (Status 422)
  String? _getDataValidationErrorMessage(Response? response) {
    try {
      DioResponseModel res = dioResponseModelFromJson(response?.data);
      if (res.errors?.email != null) {
        return res.errors?.email?.first;
      }
      if (res.errors?.contactNumber != null) {
        return res.errors?.contactNumber?.first;
      }
      if (res.errors?.name != null) {
        return res.errors?.name?.first;
      }
      if (res.errors?.firebaseUid != null) {
        return res.errors?.firebaseUid?.first;
      }
      if (res.errors?.invalidCredentials != null) {
        return res.errors?.invalidCredentials?.first;
      }

      if (res.errors?.passwordIsAlreadyReset != null) {
        return res.errors?.passwordIsAlreadyReset?.first;
      }
      if (res.errors?.password != null) {
        return res.errors?.password?.first;
      }
      if (res.errors?.invalidDefaultPassword != null) {
        return res.errors?.invalidDefaultPassword?.first;
      }
      if (res.message != null || res.message != "") {
        return res.message;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  String toString() {
    return 'ServerException{errorMessage: $errorMessage, unexpectedError: $unexpectedError, data: ${data.toString()}}';
  }
}

/// Thrown during the sign up process if a failure occurs.
class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Wrong password provided for that user.',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.',
        );
      case 'invalid-credential':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the Cloud Storage process if a failure occurs.
class CloudStorageFailure implements Exception {
  const CloudStorageFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase exception code.
  factory CloudStorageFailure.fromCode(String code) {
    switch (code) {
      case 'storage/unknown':
        return const CloudStorageFailure(
          'An unknown error occurred.',
        );
      case 'storage/object-not-found':
        return const CloudStorageFailure(
          'No object exists at the desired reference.',
        );
      case 'storage/bucket-not-found':
        return const CloudStorageFailure(
          'No bucket is configured for Cloud Storage.',
        );
      case 'storage/project-not-found':
        return const CloudStorageFailure(
          'No project is configured for Cloud Storage.',
        );
      case 'storage/quota-exceeded':
        return const CloudStorageFailure(
          "Quota on your Cloud Storage bucket has been exceeded. If you're on the no-cost tier, upgrade to a paid plan. If you're on a paid plan, reach out to Firebase support.",
        );
      case 'storage/unauthenticated':
        return const CloudStorageFailure(
          'User is not authorized to perform the desired action, check your security rules to ensure they are correct.',
        );
      case 'storage/retry-limit-exceeded':
        return const CloudStorageFailure(
          'The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded. Try uploading again.',
        );
      case 'storage/invalid-checksum':
        return const CloudStorageFailure(
          'File on the client does not match the checksum of the file received by the server. Try uploading again.',
        );
      case 'storage/canceled':
        return const CloudStorageFailure(
          'User canceled the operation.',
        );
      case 'storage/invalid-event-name':
        return const CloudStorageFailure(
          'Invalid event name provided. Must be one of [running, progress, pause].',
        );
      case 'storage/invalid-url':
        return const CloudStorageFailure(
          'Invalid URL provided to refFromURL(). Must be of the form: gs://bucket/object or https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>.',
        );
      case 'storage/invalid-argument':
        return const CloudStorageFailure(
          'The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.',
        );
      case 'storage/no-default-bucket':
        return const CloudStorageFailure(
          "No bucket has been set in your config's storageBucket property.",
        );
      case 'storage/cannot-slice-blob':
        return const CloudStorageFailure(
          "Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file hasn't changed.",
        );
      case 'storage/server-file-wrong-size':
        return const CloudStorageFailure(
          'File on the client does not match the size of the file received by the server. Try uploading again.',
        );
      default:
        return const CloudStorageFailure();
    }
  }

  /// The associated error message.
  final String message;
}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// Use to throw exception when the user not grant device permissions
class NoPermission implements Exception {}

/// Use to throw platform related exceptions
class DeviceException implements Exception {
  final String message;

  const DeviceException({
    required this.message,
  });
}
