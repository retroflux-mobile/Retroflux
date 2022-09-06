

class PdfInfo {
  late String path;
  String localPath = '';
  late List<int> favoritePages;
  String comment;
  PdfInfo({required this.path, required this.favoritePages, this.comment=""});
}
