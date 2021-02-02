import 'package:app/core/view_models/base_view_model.dart';
import 'package:app/ui/widgets/atr_preview.dart';

class AnimalTransportRecordPreViewModel extends BaseViewModel {
  /*
   TODO: #130. This class should use DatabaseService to map
   ATRPreview from the raw records, which are then pushed through here.
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
