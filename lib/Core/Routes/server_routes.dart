class ServerRoutes {
  // static const baseUrl = 'http://192.168.1.6:5000/api/v1';
  static const appwriteBaseUrl = 'https://cloud.appwrite.io/v1';
  static const appwriteProjectId = '66054f475f92582f7687';
  static const baseUrl = 'http://185.204.197.77:5000/api/v1';
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

  static getExperiences(int page) =>
      '$baseUrl/experiences?page=${page.toString()}';
  static const sendExperience = '$baseUrl/experience';
  static deleteExperience(final String id) => '$baseUrl/experiences/$id';
  static getUserExperiences(int page) =>
      '$baseUrl/user-experiences?page=${page.toString()}';
  static getLikedExperiences(int page) =>
      '$baseUrl/liked-experiences?page=${page.toString()}';

  static getReviews(int page, String reviewType, String reviewTypeId) =>
      '$baseUrl/reviews?review_type_id=$reviewTypeId&review_type=$reviewType&page=$page';
  static const sendReview = '$baseUrl/review';
  static deleteReview(final String id) => '$baseUrl/review/$id';

  static const sendReaction = '$baseUrl/send-reaction';
  static const deleteReaction = '$baseUrl/delete-reaction';
  
  static const databaseId = '6605581e48c5cfa0587e';
  static const daysCollectionId = '66055938c5a78f03cb7d';
  static const imagesCollectionId = '660974b80d1540254b8c';
}
