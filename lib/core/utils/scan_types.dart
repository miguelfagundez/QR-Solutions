enum ScanTypes {
  http('http'),
  geo('geo'),
  phone('+'),
  email('@'),
  other('other'),
  ;

  final String value;
  const ScanTypes(this.value);
}
