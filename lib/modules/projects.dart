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
        'Ola',
        'Guimaraes',
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus rhoncus commodo dui, eget molestie leo posuere sed. Ut sit amet quam risus. Donec dignissim viverra ante, eu suscipit leo tristique et. Aliquam dictum sem tortor, ac commodo lacus scelerisque fringilla. Nulla imperdiet consequat erat, eu sodales ante sollicitudin non. Aenean ac augue sollicitudin, volutpat tellus quis, cursus odio. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
        'Ola',
        'Braga',
        'Sed accumsan tempus dolor, id porttitor ipsum iaculis vel. In efficitur mattis lectus nec vulputate. Aliquam erat volutpat. Integer sagittis, enim quis tristique interdum, leo neque efficitur felis, at dignissim enim orci eget neque. Nulla facilisi. Pellentesque tempus risus quis porttitor dignissim. Donec pellentesque eros non tortor tempus, condimentum maximus neque elementum. Praesent sagittis viverra nisl sit amet ultrices. Maecenas augue orci, porta a elit nec, pretium laoreet elit. Maecenas at pharetra arcu. Donec sagittis lacinia orci, in sollicitudin ipsum aliquam eget. Ut ut scelerisque elit.',
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
        'Ola',
        'Porto',
        'Cras sit amet mauris et ipsum hendrerit pulvinar. Integer posuere turpis non odio tempor tincidunt. Donec finibus dolor diam, id bibendum est vestibulum in. Mauris elementum diam risus, nec rutrum nisi vulputate sed. Ut dignissim bibendum turpis, ut euismod turpis egestas vel. Donec sed volutpat quam. Vivamus nec lectus vestibulum, fringilla lacus sed, rhoncus felis. Mauris tempor lorem massa, quis ultrices diam sodales vel. Nullam velit lorem, aliquet eu elementum et, tristique sit amet eros. Proin pharetra eros nec nulla aliquam, at molestie magna varius. Suspendisse ut nulla nec nulla tincidunt tristique.',
        300.90,
        305.90,
        8,
      ),
    ];
  }

  List<Project> get list => _projects;
  int get count => _projects.length;
}
