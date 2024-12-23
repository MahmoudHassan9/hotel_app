class RoomDM {
  String? title;
  String? description;
  String? numberOfBeds;
  String? pricePerNight;
  String? image;
  String? area;
  String? listName;
  String? id;

  RoomDM({
    this.title,
    this.description,
    this.image,
    this.numberOfBeds,
    this.pricePerNight,
    this.area,
    this.listName,
    this.id,
  });

  factory RoomDM.fromJson(Map<String, dynamic> json) => RoomDM(
        title: json['title'],
        description: json['description'],
        numberOfBeds: json['numberOfBeds'],
        image: json['image'],
        pricePerNight: json['pricePerNight'],
        area: json['area'],
        listName: json['listName'],
        id: json['id'],

      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'numberOfBeds': numberOfBeds,
      'image': image,
      'pricePerNight': pricePerNight,
      'area': area,
      'listName': listName,
      'id': id,
    };
  }
}
