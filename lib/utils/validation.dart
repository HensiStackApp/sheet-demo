String validateName(String value) {
  if (value.isEmpty) {
    return "This field is required";
  } else {
    return null;
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (value.length == 0) {
    return "This field is required";
  } else if (!regex.hasMatch(value))
    return "Enter valid email";
  else
    return null;
}

String validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return "This field is required";
  } else if (value.length != 10) {
    return "Phone Number must be of 10 digit";
  } else {
    return null;
  }
}

String validateAddress(String value) {
  if (value.isEmpty) {
    return "This field is required";
  } else {
    return null;
  }
}

String validateBod(String value) {
  if (value.isEmpty) {
    return "This field is required";
  } else {
    return null;
  }
}

String validatePassword(String value) {
  if (value.length == 0) {
    return "This field is required";
  } else {
    return null;
  }
}
