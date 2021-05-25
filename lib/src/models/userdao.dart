class UserDAO {
  int id;
  String nomusr;
  String telusr;
  String mailusr;
  String photousr;

  UserDAO({this.id, this.nomusr, this.telusr, this.mailusr, this.photousr});
  factory UserDAO.fromJSON(Map<String, dynamic> map) {
    return UserDAO(
        id: map['id'],
        nomusr: map['nomusr'],
        telusr: map['telusr'],
        mailusr: map['mailusr'],
        photousr: map['photousr']);
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "nomusr": nomusr,
      "telusr": telusr,
      "mailusr": mailusr,
      "photousr": photousr
    };
  }
}
