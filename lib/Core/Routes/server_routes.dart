class ServerRoutes {
  static const baseUrl = 'http://192.168.1.4:5000/api/v1';
  static const login = '$baseUrl/login';
  static getData(String id) => '$baseUrl/$id';
  static const saveDays = '$baseUrl/days';
  static getDays(String dayNumber) => '$baseUrl/days/$dayNumber';
  static editDays(String id) => '$baseUrl/days/$id';
}
