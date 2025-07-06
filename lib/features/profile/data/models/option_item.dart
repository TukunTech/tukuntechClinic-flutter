class OptionItem {
  final int id;
  final String label;

  OptionItem({required this.id, required this.label});

  factory OptionItem.fromJson(Map<String, dynamic> json, String labelKey) {
    return OptionItem(
      id: json['id'],
      label: json[labelKey],
    );
  }
}
