class Environments {
  static const String baseURL = String.fromEnvironment(
    'jsonplaceholder',
    defaultValue: 'https://jsonplaceholder.typicode.com/',
  );

  static const String users = String.fromEnvironment(
    'users',
    defaultValue: '${baseURL}users/',
  );
}
