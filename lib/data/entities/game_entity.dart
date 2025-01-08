import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:joystick_junkie/core/helpers/igdb_image_url_helper.dart';

@Entity(tableName: 'games')
class GameEntity extends Equatable {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;
  final String? coverImageUrl;
  final String? summary;
  final String? storyline;
  final double? rating;
  final int? ratingCount;
  final DateTime? firstReleaseDate;

  const GameEntity({
    required this.id,
    required this.name,
    this.coverImageUrl,
    this.summary,
    this.storyline,
    this.rating,
    this.ratingCount,
    this.firstReleaseDate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        coverImageUrl,
        summary,
        storyline,
        rating,
        ratingCount,
        firstReleaseDate,
      ];

  factory GameEntity.fromJson(
    Map<String, dynamic> json, {
    IGDBImageUrlHelper urlHelper = const IGDBImageUrlHelper(),
  }) {
    String? coverImageUrl = json['cover'] != null ? urlHelper.parseUrl(json['cover']['url']) : null;

    return GameEntity(
      id: json['id'],
      name: json['name'] ?? 'Unknown',
      coverImageUrl: coverImageUrl,
      summary: json['summary'],
      storyline: json['storyline'],
      rating: (json['rating'] as num?)?.toDouble(),
      ratingCount: json['rating_count'],
      firstReleaseDate: json['first_release_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['first_release_date'] * 1000)
          : null,
    );
  }
}
