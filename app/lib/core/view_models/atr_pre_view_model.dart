import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/atr_preview.dart';

class AnimalTransportRecordPreViewModel extends BaseViewModel {
  /*
   TODO: This class should be hooked to another class to map
   ATRPreview from the raw records, which are then pushed through here
   or it should make previews from the raw here (listening function).
   */
  final List<AnimalTransportRecordPreview> _animalTransportPreviews = [];

  List<AnimalTransportRecordPreview> get animalTransportPreviews =>
      List.unmodifiable(_animalTransportPreviews);

  void add(AnimalTransportRecordPreview animalTransportPreview) {
    _animalTransportPreviews.add(animalTransportPreview);
    notifyListeners();
  }

  void removeAll() {
    _animalTransportPreviews.clear();
    notifyListeners();
  }
}
