import 'package:projeto_computacao_movel/modules/project.dart';
import '../user.dart';

class ProjectArguments {
  final String? token;
  final Project project;
  final User? user;

  ProjectArguments(
    this.token,
    this.project,
    this.user,
  );
}
