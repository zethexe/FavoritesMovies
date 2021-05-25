class TrailerDAO {
  int id;

  List<Youtube> youtube;

  TrailerDAO({this.id, this.youtube});

  TrailerDAO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['youtube'] != null) {
      youtube = new List<Youtube>();
      json['youtube'].forEach((v) {
        youtube.add(new Youtube.fromJson(v));
      });
    }
  }
}

class Youtube {
  String name;
  String size;
  String source;
  String type;

  Youtube({this.name, this.size, this.source, this.type});

  Youtube.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    size = json['size'];
    source = json['source'];
    type = json['type'];
  }
}
