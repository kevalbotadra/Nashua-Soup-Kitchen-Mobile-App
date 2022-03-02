import 'package:nsks/data/models/post.dart';
import 'package:nsks/data/models/user.dart';
import 'package:nsks/data/providers/statistic_provider.dart';
import 'package:nsks/helpers/firebase_functions.dart';

class StatisticRepository {
  StatisticProvider _statisticProvider;

  StatisticRepository(this._statisticProvider);

  Future<List<NsksUser>> getUsersBasedOnHours() async {
    List<Map<String, dynamic>> userMetaData = await _statisticProvider.getListOfUsers();
    List<Map<String, dynamic>> docs = [];

    List<NsksUser> userListBasedOnHours = [];

    userMetaData.map((doc){
      docs.add(doc);
    }).toList();
    
    for (Map<String, dynamic> doc in docs) {
      List<Post> volunteerPosts = await getPostsbyVolunteer(doc["uid"]);      
      userListBasedOnHours.add(NsksUser.fromMap(doc, volunteerPosts));
    }

    if(userListBasedOnHours.length > 10){
      userListBasedOnHours = userListBasedOnHours.sublist(0, 11);
    }

    for (var user in userListBasedOnHours){
      user.hours = getTotalHours(getPostsByVolunteerByDate(user.volunteeredPosts, "Finished"));
    }

    userListBasedOnHours.sort((b, a) => a.hours.compareTo(b.hours));

    return userListBasedOnHours;
  }

  double getTotalHours(List<Post> posts) {
    double totalHours = 0;
    for (Post post in posts) {
      totalHours += post.hours;
    }

    return totalHours;
  }
  
  List<Post> getPostsByVolunteerByDate(List<Post> posts, String filter) {
    List<Post> filteredPosts = [];

    if (filter == "Upcoming") {
      for (Post post in posts) {
        if (DateTime.now().isBefore(DateTime.parse(post.endDate))) {
          filteredPosts.add(post);
        }
      }
    } else {
      for (Post post in posts) {
        if (DateTime.now().isAfter(DateTime.parse(post.endDate))) {
          filteredPosts.add(post);
        }
      }
    }

    return filteredPosts;
  }

}