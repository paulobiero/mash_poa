import 'package:mash/Models/FaresModel.dart';
import 'package:mash/Models/SeatItem.dart';

class SelectedSeatModel {
  SelectedSeatModel(
    this.seat,
    this.fareModel,

  );

  late SeatItem seat;
  late FareModel fareModel;



}