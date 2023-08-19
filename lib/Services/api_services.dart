class ApiServices {
  /// -----> BASE URL
  static const String baseUrl = "http://disease.sh/v3/covid-19/";

  /// -----> fetch data of world covid status
  static const String worldStatusApi = baseUrl + "all";
  static const String countriesList = baseUrl + "countries";
}
