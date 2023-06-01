import 'package:projeto_computacao_movel/modules/project.dart';

class Projects {
  List<Project> _projects = [];

  Projects() {
    _projects = [
      Project(
        1,
        1,
        2,
        1,
        'House1.jpg',
        'Renovation of Affordable Apartments',
        'Guimaraes',
        'We are crowdfunding the renovation of a building to create affordable apartments for low-income individuals and families. The project aims to provide safe and comfortable housing options at affordable rents. By investing in this project, you can contribute to addressing the housing crisis and making a positive impact in the community. The estimated final value of the project is 80,000 euros. Join us in creating affordable housing opportunities!',
        0,
        1000.28,
        10,
      ),
      Project(
        2,
        1,
        2,
        1,
        'House2.jpg',
        'Cooperative Housing Development',
        'Braga',
        'Our crowdfunding project focuses on developing a cooperative housing community where residents collectively own and manage the property. The project aims to create an affordable and sustainable living environment. By investing in this project, you can become a member of the cooperative and enjoy the benefits of shared ownership. The estimated final value of the project is 60,000 euros. Join us in building an affordable and cooperative community!',
        206.25,
        800.50,
        12,
      ),
      Project(
        3,
        1,
        2,
        1,
        'House1.jpg',
        'Small-Scale Affordable Housing Project',
        'Porto',
        'We are crowdfunding the construction of a small-scale affordable housing project consisting of compact and energy-efficient units. The project aims to provide affordable homeownership options for individuals and families with limited budgets. By investing in this project, you can help address the affordability gap in the housing market. The estimated final value of the project is 100,000 euros. Join us in creating more affordable homeownership opportunities!',
        300.90,
        305.90,
        8,
      ),
    ];
  }

  List<Project> get list => _projects;
  int get count => _projects.length;
}
