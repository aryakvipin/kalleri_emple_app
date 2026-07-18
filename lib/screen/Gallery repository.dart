import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/usermodel/Gallery models.dart';


/// Single place that talks to Firestore for every screen in the Gallery
/// flow (GalleryScreen, TempleContent, EventContent, FestivalContent).
/// The widgets never call FirebaseFirestore directly — if your schema
/// changes, this is the only file that needs to change with it.
///
/// Expected collections (see FIREBASE_SETUP.md for full field lists):
///   temple_info/main        (single doc)
///   festival_info/main      (single doc)
///   featured_album/main     (single doc)
///   events                  (collection, one doc per event)
///     - dayNum: String        e.g. "19", "20", "21", "22"
///     - timeOfDay: String     "morning" | "evening"
///     - time: String          display label, e.g. "5:00 AM"
///     - sortMinutes: Number   minutes-since-midnight (0-1439), used for
///                             ordering ONLY — "time" is display-only and
///                             sorts wrong as a raw string (e.g. "10:30 AM"
///                             would sort before "5:00 AM"). Add this field
///                             to every event doc: 5:00 AM -> 300,
///                             10:30 AM -> 630, 6:00 PM -> 1080.
///     - title: String
///     - description: String
///     - imageUrl: String
///   gallery                 (collection, one doc per photo OR video)
///     - url: String
///     - thumbnailUrl: String?   only needed for videos
///     - category: String        "temple" | "festivals" | "events"
///     - mediaType: String       "photo" | "video" — REQUIRED to tell
///                               watchPhotos() and watchVideos() apart,
///                               since they now share one collection.
///     - order: Number
class GalleryRepository {
  GalleryRepository._();
  static final GalleryRepository instance = GalleryRepository._();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<TempleInfo> fetchTempleInfo() async {
    final doc = await _db.collection('temple_info').doc('main').get();
    return TempleInfo.fromDoc(doc);
  }

  Future<FestivalInfo> fetchFestivalInfo() async {
    final doc = await _db.collection('festival_info').doc('main').get();
    return FestivalInfo.fromDoc(doc);
  }

  Future<FeaturedAlbum> fetchFeaturedAlbum() async {
    final doc = await _db.collection('featured_album').doc('main').get();
    return FeaturedAlbum.fromDoc(doc);
  }

  /// Live list of events for a given day, ordered chronologically by
  /// `sortMinutes` (minutes-since-midnight) rather than the display
  /// `time` string, so "10:30 AM" doesn't sort before "5:00 AM".
  ///
  /// If your existing `events` docs don't have `sortMinutes` yet, add it
  /// to each doc (see the collection notes above) — this orderBy will
  /// simply return nothing for docs missing the field until then.
  Stream<List<EventEntryModel>> watchEvents(String dayNum) {
    return _db
        .collection('events')
        .where('dayNum', isEqualTo: dayNum)
        .orderBy('sortMinutes')
        .snapshots()
        .map((snap) => snap.docs.map(EventEntryModel.fromDoc).toList());
  }

  /// category: 'temple' | 'festivals' | 'events' | null (null = all).
  /// Filters the shared `gallery` collection down to mediaType == 'photo'
  /// so this never picks up video docs.
  Stream<List<GalleryMediaItem>> watchPhotos({String? category}) {
    Query<Map<String, dynamic>> q = _db
        .collection('gallery')
        .where('mediaType', isEqualTo: 'photo');
    if (category != null) q = q.where('category', isEqualTo: category);
    return q.orderBy('order').snapshots().map(
            (snap) => snap.docs.map(GalleryMediaItem.fromDoc).toList());
  }

  /// category: 'temple' | 'festivals' | 'events' | null (null = all).
  /// Filters the shared `gallery` collection down to mediaType == 'video'
  /// so this never picks up photo docs.
  Stream<List<GalleryMediaItem>> watchVideos({String? category}) {
    Query<Map<String, dynamic>> q = _db
        .collection('gallery')
        .where('mediaType', isEqualTo: 'video');
    if (category != null) q = q.where('category', isEqualTo: category);
    return q.orderBy('order').snapshots().map(
            (snap) => snap.docs.map(GalleryMediaItem.fromDoc).toList());
  }
}