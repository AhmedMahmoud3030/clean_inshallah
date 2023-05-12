class ApiConstants {
  static const String baseUrl = 'https://api.flickr.com/services/rest/';
  static const String apiKey = '374fde9381998d14a84a7a58d82e2291';
  static const String url = '';
  static String imageUrl(String secret, String server, String id) =>
      "https://live.staticflickr.com/$server/${id}_$secret.jpg";

  static String searchImage(String query) =>
      "$baseUrl?method=flickr.photos.search&api_key=$apiKey&text=$query&format=json&nojsoncallback=1";
}
