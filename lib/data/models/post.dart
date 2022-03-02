import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsks/data/models/user.dart';

class Post {
  final String uniqueId;
  final String title;
  final String imageUrl;
  final String body;
  final List<dynamic> tags;
  final String createdAt;
  final String startDate;
  final String endDate;
  final List<NsksUser> volunteers;
  final double hours;
  final String location;

  Post(
      {required this.uniqueId,
      required this.title,
      required this.imageUrl,
      required this.body,
      required this.tags,
      required this.startDate,
      required this.endDate,
      required this.createdAt,
      required this.volunteers,
      required this.hours,
      required this.location});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uniqueId: json["uid"],
      title: json["title"],
      imageUrl: json["imageUrl"] ?? "no image url",
      body: json["body"],
      tags: json["tags"],
      createdAt: json["createdAt"].toDate().toString(),
      startDate: json["startDate"].toDate().toString(),
      endDate: json["endDate"].toDate().toString(),
      volunteers: [],
      hours: json["hours"].toDouble(),
      location: json["location"],
    );
  }

  factory Post.fromSnapshot(
      DocumentSnapshot snapshot, List<NsksUser> volunteers) {
    return Post(
      uniqueId: snapshot["uid"],
      title: snapshot["title"],
      imageUrl: snapshot["imageUrl"] ?? "no image url",
      body: snapshot["body"],
      tags: snapshot["tags"],
      createdAt: snapshot["createdAt"].toDate().toString(),
      startDate: snapshot["startDate"].toDate().toString(),
      endDate: snapshot["endDate"].toDate().toString(),
      volunteers: volunteers,
      hours: snapshot["hours"].toDouble(),
      location: snapshot["location"],
    );
  }

  factory Post.fromMap(Map<String, dynamic> json, List<NsksUser> volunteers) {
    return Post(
      uniqueId: json["uid"],
      title: json["title"],
      imageUrl: json["imageUrl"] ?? "no image url",
      body: json["body"],
      tags: json["tags"],
      createdAt: json["createdAt"].toDate().toString(),
      startDate: json["startDate"].toDate().toString(),
      endDate: json["endDate"].toDate().toString(),
      volunteers: volunteers,
      hours: json["hours"].toDouble(),
      location: json["location"],
    );
  }
}

// Django Backend Info:
// title = models.CharField(max_length=255)
// image = models.FileField(null=True, upload_to=upload_to)
// body = models.CharField(max_length=2000, null=True, blank=True)
// created_at = models.DateTimeField(auto_now_add=True)
// user = models.ForeignKey(User, on_delete=models.CASCADE)

// title = self.title,
// image = self.image,
// body = self.body,
// created_at = self.created_at,
// user = self.user.as_json()
