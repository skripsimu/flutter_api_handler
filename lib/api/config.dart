enum Environment {DEVELOPMENT, STAGING, PRODUCTION}

class Config {
  static Environment environment = Environment.DEVELOPMENT;

  static String get baseUrl {
    String apiUrl = '';
    switch (environment) {
      case Environment.DEVELOPMENT:
        apiUrl = 'https://jsonplaceholder.typicode.com';
        break;
      case Environment.STAGING:
        apiUrl = 'https://jsonplaceholder.typicode.com';
        break;
      case Environment.DEVELOPMENT:
        apiUrl = 'https://jsonplaceholder.typicode.com';
        break;
    }
    return apiUrl;
  }
}