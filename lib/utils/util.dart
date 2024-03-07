String getWeatherImage(String input) {
  String weather = input.toLowerCase();
  String assetPath = 'assets/images/';
  switch (weather) {
    case 'thunderstorm':
      return '${assetPath}Storm.png';

    case 'drizzle':
    case 'rain':
      return '${assetPath}Rainy.png';

    case 'snow':
      return '${assetPath}Snow.png';

    case 'clear':
      return '${assetPath}Sunny.png';

    case 'clouds':
      return '${assetPath}Cloudy.png';

    case 'mist':
    case 'fog':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'sand':
    case 'ash':
      return '${assetPath}Fog.png';

    case 'squall':
    case 'tornado':
      return '${assetPath}StormWindy.png';

    default:
      return '${assetPath}Cloud.png';
  }
}