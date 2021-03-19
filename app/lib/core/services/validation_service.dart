class ValidationService {
  String stringFieldValidator(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else {
      return null;
    }
  }

  String intFieldValidator(int value) {
    if (value == null || value == 0) {
      return "* Required";
    } else {
      return null;
    }
  }

  String nonNullIntFieldValidator(int value) {
    if (value == null) {
      return "* Required";
    } else {
      return null;
    }
  }

  String canBeEmptyFieldValidator(String value) => null;

  String passwordValidator(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be at least 6 characters";
    } else if (value.length > 10) {
      return "Password should not be greater than 10 characters";
    } else {
      return null;
    }
  }

  String emailValidator(String value) {
    if (value.isEmpty) {
      return '* Required';
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(value)) {
      return '* Please enter a valid Email';
    } else {
      return null;
    }
  }
}
