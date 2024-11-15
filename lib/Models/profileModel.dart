// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  String name;
  String image;

  Profile({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
}
