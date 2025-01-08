class IGDBImageUrlHelper {
  const IGDBImageUrlHelper();
  String parseUrl(String url, {String size = '1080p'}) {
    url = url.replaceAll('//', 'https://');

    url = url.replaceAll('t_thumb', 't_$size');

    return url;
  }
}
