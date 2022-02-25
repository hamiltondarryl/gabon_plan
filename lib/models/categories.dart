
class Categories {
    Categories({
        required this.id,
        required this.libelle,
    });

    String id;
    String libelle;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        libelle: json["libelle"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
    };
}