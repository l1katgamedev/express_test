class MovieDetail {
  dynamic id;
  dynamic popularity;
  dynamic title;
  dynamic backPoster;
  dynamic poster;
  dynamic overview;
  dynamic rating;
  dynamic releaseDate;

  MovieDetail({
    this.id,
    this.popularity,
    this.title,
    this.backPoster,
    this.poster,
    this.overview,
    this.rating,
    this.releaseDate,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    return MovieDetail(
      id: json["id"],
      popularity: json["popularity"] ?? 0,
      title: json["title"] ?? "",
      backPoster: json["backdrop_path"] ?? "",
      poster: json["poster_path"] ?? "",
      overview: json["overview"] ?? "",
      rating: json["vote_average"] ?? 0.0,
      releaseDate: json["release_date"] ?? "",
    );
  }
}
