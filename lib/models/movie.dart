class Movie {
  dynamic id;
  dynamic name;
  dynamic language;
  dynamic isAdult;
  dynamic description;
  dynamic poster;
  dynamic rating;
  dynamic releaseDate;

  Movie({
     this.id,
     this.name,
     this.language,
     this.isAdult,
     this.description,
     this.poster,
     this.rating,
     this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      name: json['title'] ?? "",
      language: json['original_language'] ?? "DK",
      isAdult: json['adult'] ?? "DK",
      description: json['overview'] ?? "",
      poster: json['poster_path'] ?? "",
      rating: json['vote_average'] ?? 0.0,
      releaseDate: json['release_date'] ?? "",
    );
  }
}
