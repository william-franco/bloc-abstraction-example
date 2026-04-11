import 'package:bloc_abstraction_example/src/common/services/connection_service.dart';
import 'package:bloc_abstraction_example/src/common/services/http_service.dart';
import 'package:bloc_abstraction_example/src/features/users/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ConnectionService, HttpService, UserRepository])
void main() {}
