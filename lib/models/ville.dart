class Ville {
    Ville({
        required this.id,
        required this.libelle,
    });

    String id;
    String libelle;

    factory Ville.fromJson(Map<String, dynamic> json) => Ville(
        id: json["id"],
        libelle: json["libelle"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
    };
}
