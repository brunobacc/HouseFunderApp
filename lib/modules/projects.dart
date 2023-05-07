import 'package:projeto_computacao_movel/modules/project.dart';

class Projects {
  List<Project> _projects = [];

  Projects() {
    _projects = [
      Project(
          1, 1, 2, 1, 'House1.jpg', 'Ola', 'Guimaraes', 'OlaOla', 1000.28, 10),
      Project(2, 1, 2, 1, 'House2.jpg', 'Ola', 'Braga', 'OlaOla', 800.50, 12),
      Project(3, 1, 2, 1, 'House1.jpg', 'Ola', 'Porto', 'OlaOla', 305.90, 8),
    ];
  }

  List<Project> get list => _projects;
  int get count => _projects.length;
}
