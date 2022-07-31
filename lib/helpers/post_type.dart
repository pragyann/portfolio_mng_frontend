enum PostType {
  photo,
  video,
}

extension PostTypeGetters on PostType {
  bool get isPhoto => this == PostType.photo;
  bool get isVideo => this == PostType.video;
}

PostType postTypeFromString(String text) {
  return PostType.values.firstWhere((e) => e.toString() == 'PostType.$text');
}
