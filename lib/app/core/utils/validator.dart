class Validator {
  Validator._();

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Preencha com um e-mail válido';
    } else {
      return null;
    }
  }
  static String? validatepassword(String? value) {
    if (value!.length <= 6 || value == null) {
      return 'A sua senha deve conter mais de 6 caracteres';
    } else {
      return null;
    }
  }
}
