import 'dart:convert';
import 'package:covid_19_tracker_app/Models/world_status_model.dart';
import 'package:covid_19_tracker_app/Services/api_services.dart';
import 'package:http/http.dart' as http;

/// -----> In this class Status Services
/// -----> We'll fetch and show the data
/// -----> World Status COVID - 19
class StatusServices {
  Future<WorldStatusModel> fetchWorldStatusData() async {
    final response = await http.get(Uri.parse(ApiServices.worldStatusApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      try {
        return WorldStatusModel.fromJson(data);
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception("Error");
    }
  }
}
