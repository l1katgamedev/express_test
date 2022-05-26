class Cast {
  dynamic id;
  dynamic name;
  dynamic character;
  dynamic profileImg;
  dynamic birthday;
  dynamic rating;
  dynamic bio;

  Cast({
    this.id,
    this.name,
    this.character,
    this.profileImg,
    this.birthday,
    this.rating,
    this.bio,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json["id"],
      name: json["name"] ?? "Access Denied",
      character: json["character"]?? "",
      profileImg: json["profile_path"] ?? "",
      birthday: json["birthday"] ?? "",
      rating: json['popularity'] ?? 0,
      bio: json['biography'] ?? '',
    );
  }
}
