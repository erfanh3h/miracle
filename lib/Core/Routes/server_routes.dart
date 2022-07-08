class ServerRoutes {
  static const baseUrl = 'http://192.168.1.4:5000/api/v1';
  static const enterPhone = '$baseUrl/enter';
  static const sendCode = '$baseUrl/code';
  static getData(String id) => '$baseUrl/$id';
  static const saveDays = '$baseUrl/days';
  static getDays(String dayNumber) => '$baseUrl/days/$dayNumber';
  static editDays(String id) => '$baseUrl/days/$id';
  static const uploadFile = '$baseUrl/file';
  static getFile(String fileId) => '$baseUrl/files/$fileId';
  static const selfUser = '$baseUrl/user';
  static const changeDayStatus = '$baseUrl/save-day-status';
  static const changeUsername = '$baseUrl/username';
  static const changeUserImage = '$baseUrl/user-image';
  static const deleteUserImage = '$baseUrl/delete-image';
}
