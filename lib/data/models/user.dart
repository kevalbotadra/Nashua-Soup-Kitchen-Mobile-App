import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nsks/data/models/post.dart';

class NsksUser {
  final bool isValid;
  final String uid;
  final String username;
  final String name;
  final String bio;
  final String phoneNumber;
  final String pfpUrl;
  final bool isStaff;
  final bool isVerified;
  double hours;
  List<Post> volunteeredPosts;

  NsksUser(
      {required this.isValid,
      this.uid = "ASASFASFASF",
      this.username = "",
      this.name = "",
      this.bio = "",
      this.phoneNumber = "",
      this.pfpUrl = "",
      this.isStaff = false,
      this.isVerified = false,
      this.hours = 0,
      this.volunteeredPosts = const []});



  factory NsksUser.fullFromSnapshot(DocumentSnapshot snapshot, List<Post> posts) {
    return NsksUser(
        isValid: true,
        uid: snapshot["uid"],
        username: snapshot["username"],
        name: snapshot["name"],
        bio: snapshot["bio"],
        pfpUrl: snapshot["pfpUrl"] != ""
            ? snapshot["pfpUrl"]
            : "https://www.pinclipart.com/picdir/big/z157-1578186_user-profile-default-image-png-clipart.png",
        phoneNumber: snapshot["phoneNumber"],
        isStaff: snapshot["isStaff"],
        isVerified: snapshot["isVerified"],
        volunteeredPosts: posts,
        hours: snapshot["hours"].toDouble());
  }

  factory NsksUser.lessFromSnapshot(DocumentSnapshot snapshot) {
    return NsksUser(
        isValid: true,
        uid: snapshot["uid"],
        username: snapshot["username"],
        name: snapshot["name"],
        bio: snapshot["bio"],
        pfpUrl: snapshot["pfpUrl"] != ""
            ? snapshot["pfpUrl"]
            : "https://www.pinclipart.com/picdir/big/157-1578186_user-profile-default-image-png-clipart.png",
        phoneNumber: snapshot["phoneNumber"],
        isStaff: snapshot["isStaff"],
        isVerified: snapshot["isVerified"],
        hours: snapshot["hours"].toDouble());}

    factory NsksUser.fromMap(Map<String, dynamic> map, List<Post> posts) {
      return NsksUser(
        isValid: true,
        uid: map["uid"],
        username: map["username"],
        name: map["name"],
        bio: map["bio"],
        pfpUrl: map["pfpUrl"] != ""
            ? map["pfpUrl"]
            : "https://www.pinclipart.com/picdir/big/157-1578186_user-profile-default-image-png-clipart.png",
        phoneNumber: map["phoneNumber"],
        isStaff: map["isStaff"],
        isVerified: map["isVerified"],
        hours: map["hours"].toDouble(),
        volunteeredPosts: posts,
      );
    }
}


// Django  Backend Info:
  // username = models.CharField(max_length=255, unique=True)
  // name = models.CharField(max_length=50, default="New User")
  // email = models.CharField(max_length=255, unique=True)
  // profile_picture = models.FileField(upload_to=upload_to, default="default.png")
  // is_staff = models.BooleanField(default=False)
  // is_active = models.BooleanField(default=True)

  // username = self.username,
  // name = self.name,
  // email = self.email,
  // pfp = self.pfp.url,
  // is_staff = self.is_staff
