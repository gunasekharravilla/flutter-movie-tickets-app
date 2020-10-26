part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);
  @override
  List<Object> get props => [name];
}

List<Theater> dummyTheaters = [
  Theater("Mandala 21"),
  Theater("Movimax Sarinah Malang"),
  Theater("Transmart MX Mall XXI"),
  Theater("Movimax Dinoyo")
];
