class vid_model {
  int? id;
  String? title;
  String? videoUrl;
  String? coverPicture;

  vid_model({this.id, this.title, this.coverPicture, this.videoUrl});

  vid_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    coverPicture = json['coverPicture'];
  }
}
