class ConfigService {
  static final ConfigService instance = ConfigService._();

  late final String baseUrl;

  ConfigService._();

  void initialize() {
    baseUrl = const String.fromEnvironment('BASE_URL');

    if (baseUrl.isEmpty) {
      throw Exception('BASE_URL must be initialized.');
    }
  }
}
