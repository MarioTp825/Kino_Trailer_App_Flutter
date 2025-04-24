class MovieUI {
  MovieUI({
      String? id, 
      String? title, 
      String? imageUrl, 
      String? videoUrl,
      String? youtubeId,
      String? websiteUrl,
      String? category,
      bool? favorite,
      num? views,}){
    _id = id;
    _title = title;
    _imageUrl = imageUrl;
    _videoUrl = videoUrl;
    _youtubeId = youtubeId;
    _websiteUrl = websiteUrl;
    _category = category;
    _favorite = favorite;
    _views = views;
}

  MovieUI.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _imageUrl = json['imageUrl'];
    _videoUrl = json['videoUrl'];
    _youtubeId = json['youtubeId'];
    _websiteUrl = json['websiteUrl'];
    _category = json['category'];
    _views = json['views'];
    _favorite = json['favorite'];
  }
  String? _id;
  String? _title;
  String? _imageUrl;
  String? _videoUrl;
  String? _youtubeId;
  String? _websiteUrl;
  String? _category;
  num? _views;
  bool? _favorite;
MovieUI copyWith({  String? id,
  String? title,
  String? imageUrl,
  String? videoUrl,
  String? youtubeId,
  String? websiteUrl,
  String? category,
  bool? favorite,
  num? views,
}) => MovieUI(  id: id ?? _id,
  title: title ?? _title,
  imageUrl: imageUrl ?? _imageUrl,
  videoUrl: videoUrl ?? _videoUrl,
  youtubeId: youtubeId ?? _youtubeId,
  websiteUrl: websiteUrl ?? _websiteUrl,
  category: category ?? _category,
  views: views ?? _views,
  favorite: favorite ?? _favorite,
);
  String? get id => _id;
  String? get title => _title;
  String? get imageUrl => _imageUrl;
  String? get videoUrl => _videoUrl;
  String? get youtubeId => _youtubeId;
  String? get websiteUrl => _websiteUrl;
  String? get category => _category;
  num? get views => _views;
  bool? get favorite => _favorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['imageUrl'] = _imageUrl;
    map['videoUrl'] = _videoUrl;
    map['youtubeId'] = _youtubeId;
    map['websiteUrl'] = _websiteUrl;
    map['category'] = _category;
    map['views'] = _views;
    map['favorite'] = _favorite;
    return map;
  }

}