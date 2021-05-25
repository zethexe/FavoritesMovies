class Liked {
  int id;
  String mailusr;
  int idMovie;
  String get getMailusr => this.mailusr;

  set setMailusr(String mailusr) => this.mailusr = mailusr;

  get getIdMovie => this.idMovie;

  set setIdMovie(idMovie) => this.idMovie = idMovie;

  Liked({this.mailusr, this.idMovie});

  Liked.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mailusr = json['mailusr'];
    idMovie = json['idMovie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mailusr'] = this.mailusr;
    data['idMovie'] = this.idMovie;
    return data;
  }
}
