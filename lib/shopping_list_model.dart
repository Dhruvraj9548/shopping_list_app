class Item{
  final int? id;
  final String title;
  final String description;


  const Item({required this.title, required this.description, this.id});

  factory Item.fromJson(Map<String,dynamic> json) => Item(
      id: json['id'],
      title: json['title'],
      description: json['description']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description
  };

}