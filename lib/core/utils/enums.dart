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

enum Languages {
  en('en'),
  es('es'),
  ;

  final String value;
  const Languages(this.value);
}
