import 'package:app/core/enums/auth_result_status.dart';

class ExceptionHandler {
  static handleException(e) {
    var status;
    switch (e.code) {
      case "invalid-email":
        status = ResultStatus.invalidEmail;
        break;
      case "wrong-password":
        status = ResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = ResultStatus.userNotFound;
        break;
      case "email-already-in-use":
        status = ResultStatus.emailAlreadyUsed;
        break;
      case "weak-password":
        status = ResultStatus.weakpassword;
        break;
      default:
        status = ResultStatus.undefined;
    }
    return status;
  }

  static exceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case ResultStatus.invalidEmail:
        errorMessage = "Enter a valid email address";
        break;
      case ResultStatus.wrongPassword:
        errorMessage = "Sorry, the password you entered isn't right";
        break;
      case ResultStatus.userNotFound:
        errorMessage = "Account does not exist";
        break;
      case ResultStatus.emailAlreadyUsed:
        errorMessage = "The email is already in use. Please use another one";
        break;
      case ResultStatus.weakpassword:
        errorMessage = "Password is too weak";
        break;
      default:
        errorMessage = "Opps, something went wrong </3";
    }

    return errorMessage;
  }
}
