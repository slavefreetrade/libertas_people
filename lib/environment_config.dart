class EnvironmentConfig {
  static const _envStr = String.fromEnvironment('ENV', defaultValue: 'prod');
  static Environment getEnv() => _envStr.toEnv();
  static bool get isProd => getEnv() == Environment.prod;
}

enum Environment { prod, test }

extension on Environment {
  String toValue() => toString().split('.').last;
}

extension on String {
  Environment toEnv() {
    if (contains(Environment.test.toValue())) {
      return Environment.test;
    }
    return Environment.prod;
  }
}
