class Credits {
  dynamic id;
  dynamic title;
  dynamic character;
  dynamic poster;

  Credits({
    this.id,
    this.character,
    this.title,
    this.poster,
  });

  factory Credits.fromJson(Map<String, dynamic> json) {
    return Credits(
      id: json["id"],
      title: json["title"] ?? "Access Denied",
      character: json["character"]?? "",
      poster: json["poster_path"] ?? "",
    );
  }
}
