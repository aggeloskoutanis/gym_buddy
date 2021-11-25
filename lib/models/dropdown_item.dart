class DropDownItem {

  final String id;
  final DateTime? createdAt;
  final String name;
  final String desc;

  DropDownItem({required this.id,this.createdAt, required this.name, required this.desc});

  factory DropDownItem.fromJson(Map<String, dynamic> json) {

    return DropDownItem(
      id: json["id"],
      createdAt:
        json["createdAt"] = DateTime.tryParse(json["createdAt"]),
      name: json["name"],
      desc: json["desc"],
    );

  }

  static List<DropDownItem>? fromJsonList(List list) {
    return list.map((item) => DropDownItem.fromJson(item)).toList();
  }

  String useAsString() {
    return name;
  }

  bool? userFilterByCreationDate(String filter) {
    return createdAt?.toString().contains(filter);
  }

  bool isEqual(DropDownItem model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}