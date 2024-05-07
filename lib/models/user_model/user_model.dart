class UserModel {
  String uid;
  String email;
  int availableDiamonds;
  int totalAds;
  int totalBgRemoved;
  List<String> bgRemovedImageLinks;

  UserModel({
    required this.uid,
    required this.email,
    required this.availableDiamonds,
    required this.totalAds,
    required this.totalBgRemoved,
    required this.bgRemovedImageLinks,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      availableDiamonds: json['available_diamonds'] as int,
      totalAds: json['total_ads'] as int,
      totalBgRemoved: json['total_bg_removed'] as int,
      bgRemovedImageLinks: (json['bg_removed_image_links'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['available_diamonds'] = availableDiamonds;
    data['total_ads'] = totalAds;
    data['total_bg_removed'] = totalBgRemoved;
    data['bg_removed_image_links'] = bgRemovedImageLinks;
    return data;
  }
}
