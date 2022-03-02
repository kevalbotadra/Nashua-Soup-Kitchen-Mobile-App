class NonFieldError {
  final String message;

  NonFieldError({required this.message});
  
   factory NonFieldError.fromJSON(Map<String, dynamic> json) {
    return NonFieldError(message: json["non_field_error"]);
  }

}