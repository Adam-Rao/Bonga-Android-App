class SearchResultModel {
  final String? about;
  final bool? aboutVisible;
  final String? profilePicture;
  final bool? profilePictureVisible;
  final String? username;
  final String? userID;
  final bool? isOnline;

  const SearchResultModel(
    this.about,
    this.aboutVisible,
    this.profilePicture,
    this.profilePictureVisible,
    this.username,
    this.userID,
    this.isOnline
  );
}
