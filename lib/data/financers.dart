import 'package:projeto_computacao_movel/modules/financer.dart';

class Financers {
  List<Financer> _financers = [];

  Financers() {
    _financers = [
      Financer(
        name: 'BrunoBACC',
        image: 'assets/images/avatars/image19.png',
      ),
      Financer(
        name: 'Carlos',
        image: 'assets/images/avatars/image20.png',
      ),
      Financer(
        name: 'Maria',
        image: 'assets/images/avatars/image21.png',
      ),
      Financer(
        name: 'Joana',
        image: 'assets/images/avatars/image22.png',
      ),
      Financer(
        name: 'João',
        image: 'assets/images/avatars/image23.png',
      ),
    ];
  }
  List<Financer> get list => _financers;
  int get countFinancers => _financers.length;
}
