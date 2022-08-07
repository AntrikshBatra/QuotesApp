class AuthorModel {
  final String id;
  final String authorName;
  final String content;

  AuthorModel(
      {required this.id, required this.authorName, required this.content});

  factory AuthorModel.fromJson(dynamic json) {
    return AuthorModel(
        id: json["_id"] ?? "",
        authorName: json["author"] ?? "",
        content: json["content"] ?? "");
  }

  Map<String, dynamic> toJson() => {
    "_id":id,
    "author":authorName,
    "content":content
  };

  static List<AuthorModel> authorFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return AuthorModel.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Author {id: $id , authorName= $authorName , content = $content}';
  }
}
