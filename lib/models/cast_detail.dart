class CastDetail {
  dynamic id;
  dynamic name;
  dynamic character;
  dynamic profileImg;
  dynamic birthday;
  dynamic rating;
  dynamic bio;

  CastDetail({
    this.id,
    this.name,
    this.character,
    this.profileImg,
    this.birthday,
    this.rating,
    this.bio,
  });

  factory CastDetail.fromJson(Map<String, dynamic> json) {
    return CastDetail(
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
