import 'dart:convert';

import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:blog_app/core/utils/extensions.dart';
import 'package:blog_app/core/data/data_source/remote/api_configs.dart';

import '../../../../../../core/model/error/exception.dart';
import '../../../../../../core/services/api_service.dart';
import '../../../../shared/model/user.dart';

class PostApiClient {
  PostApiClient({required APIService apiService}) : _apiService = apiService;

  final APIService _apiService;

  final Map<String, String> _authHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<Posts> getPosts() async {
    final url = Uri.https(ApiConfigs.baseUrlPath, ApiConfigs.postsPath)..log();

    try {
      final response = await _apiService.get(url: url, headers: _authHeaders);
      return Posts.fromJson(jsonDecode(response.body));
    } on ServerException catch (_) {
      _.log();
      rethrow;
    }
  }

  Future<Users> getUsers() async {
    final url = Uri.https(ApiConfigs.baseUrlPath, ApiConfigs.usersPath)..log();

    try {
      final response = await _apiService.get(url: url, headers: _authHeaders);
      return Users.fromJson(jsonDecode(response.body));
    } on ServerException catch (_) {
      _.log();
      rethrow;
    }
  }
}
