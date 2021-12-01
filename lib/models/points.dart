class PointlModel {
  PointlModel({
    required this.id,
    required this.libelle,
    required this.ville,
    required this.catId,
    required this.description,
    required this.adresse,
    required this.contact,
    required this.email,
    required this.site,
    required this.horaires,
    required this.jours,
    required this.lng,
    required this.lat,
    required this.image,
  });

  String id;
  String libelle;
  String ville;
  String catId;
  String description;
  String adresse;
  String contact;
  String email;
  String site;
  String horaires;
  String jours;
  double lng;
  double lat;
  String image;

  factory PointlModel.fromJson(Map<String, dynamic> json) => PointlModel(
    id: json["id"],
    libelle: json["libelle"],
    ville: json["ville"],
    catId: json["cat_id"],
    description: json["description"],
    adresse: json["adresse"],
    contact: json["contact"],
    email: json["email"],
    site: json["site"],
    horaires: json["horaires"],
    jours: json["jours"],
    lng: json["lng"],
    lat: json["lat"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "libelle": libelle,
    "ville": ville,
    "cat_id": catId,
    "description": description,
    "adresse": adresse,
    "contact": contact,
    "email": email,
    "site": site,
    "horaires": horaires,
    "jours": jours,
    "lng": lng,
    "lat": lat,
    "image": image,
  };
}