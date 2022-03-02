// import 'package:built_value/built_value.dart';

// part "notification.g.dart";

// abstract class Notification
//     implements Built<Notification, NotificationBuilder> {
//   Notification._();

//   factory Notification([updates(NotificationBuilder b)]) = _$Notification;

//   @nullable
//   String get notificationType;

//   @nullable
//   int get notificationId;

//   @nullable
//   String get notificationTitle;

//   @nullable
//   String get notificationBody;

//   // String toJson() {
//   //   return json.encode(serializers.serializeWith(Notification.serializer, this));
//   // }

//   // static Notification fromJson(String jsonString) {
//   //   return serializers.deserializeWith(
//   //       Notification.serializer, json.decode(jsonString));
//   // }

//   // static Serializer<Notification> get serializer => _$notificationSerializer;
// }