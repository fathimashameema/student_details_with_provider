import 'package:animated_custom_dropdown/custom_dropdown.dart';

List<Batch> batches = [
  Batch('Batch'),
  Batch('BCR60'),
  Batch('BCR61'),
  Batch('BCR62'),
  Batch('BCR63'),
  Batch('BCR64'),
];

class Batch with CustomDropdownListFilter {
  final String name;

  Batch(
    this.name,
  );

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
