import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Maps a short icon-name string stored in Firestore to a Flutter IconData.
/// Add an entry here whenever you introduce a new icon name in a document
/// — this is the only place that needs to change.
IconData iconFromName(String? name) {
  switch (name) {
    case 'info':
      return Icons.info_outline;
    case 'book':
      return Icons.auto_stories_outlined;
    case 'place':
      return Icons.place_outlined;
    case 'favorite':
      return Icons.favorite_border;
    case 'fire':
      return Icons.local_fire_department_outlined;
    case 'star':
      return Icons.star_border;
    case 'event':
      return Icons.event_note_outlined;
    case 'location':
      return Icons.location_on_outlined;
    default:
      return Icons.info_outline;
  }
}

/// One "icon + title + paragraph" block, used for the About/Legend/etc.
/// sections on both the Temple and Festival detail pages.
class InfoSection {
  final IconData icon;
  final String title;
  final String body;

  InfoSection({required this.icon, required this.title, required this.body});

  factory InfoSection.fromMap(Map<String, dynamic> map) {
    return InfoSection(
      icon: iconFromName(map['icon'] as String?),
      title: map['title'] as String? ?? '',
      body: map['body'] as String? ?? '',
    );
  }
}

class TempleInfo {
  final String title;
  final String malayalamTitle;
  final String heroImageUrl;
  final List<InfoSection> sections;

  TempleInfo({
    required this.title,
    required this.malayalamTitle,
    required this.heroImageUrl,
    required this.sections,
  });

  factory TempleInfo.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return TempleInfo(
      title: data['title'] as String? ?? '',
      malayalamTitle: data['malayalamTitle'] as String? ?? '',
      heroImageUrl: data['heroImageUrl'] as String? ?? '',
      sections: ((data['sections'] as List?) ?? const [])
          .map((e) => InfoSection.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

class FestivalInfo {
  final String title;
  final String malayalamTitle;
  final String heroImageUrl;
  final String dateRangeLabel;
  final String duration;
  final String location;
  final List<InfoSection> sections;

  FestivalInfo({
    required this.title,
    required this.malayalamTitle,
    required this.heroImageUrl,
    required this.dateRangeLabel,
    required this.duration,
    required this.location,
    required this.sections,
  });

  factory FestivalInfo.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return FestivalInfo(
      title: data['title'] as String? ?? '',
      malayalamTitle: data['malayalamTitle'] as String? ?? '',
      heroImageUrl: data['heroImageUrl'] as String? ?? '',
      dateRangeLabel: data['dateRangeLabel'] as String? ?? '',
      duration: data['duration'] as String? ?? '',
      location: data['location'] as String? ?? '',
      sections: ((data['sections'] as List?) ?? const [])
          .map((e) => InfoSection.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }
}

/// One event card on the Events tab. `dayNum`/`timeOfDay` are what the
/// calendar strip and Morning/Evening section headers filter and group by.
class EventEntryModel {
  final String id;
  final String dayNum; // e.g. "19" — matches the calendar strip
  final String dayLabel; // e.g. "Sun"
  final String timeOfDay; // 'morning' or 'evening'
  final String time; // display string, e.g. "5:00 AM"
  final String title;
  final String description;
  final String imageUrl;

  EventEntryModel({
    required this.id,
    required this.dayNum,
    required this.dayLabel,
    required this.timeOfDay,
    required this.time,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory EventEntryModel.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return EventEntryModel(
      id: doc.id,
      dayNum: data['dayNum'] as String? ?? '',
      dayLabel: data['dayLabel'] as String? ?? '',
      timeOfDay: data['timeOfDay'] as String? ?? 'morning',
      time: data['time'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
    );
  }
}

/// One photo or video in the gallery grids. `thumbnailUrl` is only
/// populated for videos (the play-button overlay uses it); `url` is the
/// full-size photo, or the underlying video file for videos.
class GalleryMediaItem {
  final String id;
  final String url;
  final String category; // 'temple' | 'festivals' | 'events'
  final int order;
  final String? thumbnailUrl;

  GalleryMediaItem({
    required this.id,
    required this.url,
    required this.category,
    required this.order,
    this.thumbnailUrl,
  });

  factory GalleryMediaItem.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return GalleryMediaItem(
      id: doc.id,
      url: data['url'] as String? ?? '',
      category: data['category'] as String? ?? 'temple',
      order: (data['order'] as num?)?.toInt() ?? 0,
      thumbnailUrl: data['thumbnailUrl'] as String?,
    );
  }
}

class FeaturedAlbum {
  final String title;
  final String coverImageUrl;
  final int photoCount;
  final int videoCount;

  FeaturedAlbum({
    required this.title,
    required this.coverImageUrl,
    required this.photoCount,
    required this.videoCount,
  });

  factory FeaturedAlbum.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return FeaturedAlbum(
      title: data['title'] as String? ?? '',
      coverImageUrl: data['coverImageUrl'] as String? ?? '',
      photoCount: (data['photoCount'] as num?)?.toInt() ?? 0,
      videoCount: (data['videoCount'] as num?)?.toInt() ?? 0,
    );
  }
}