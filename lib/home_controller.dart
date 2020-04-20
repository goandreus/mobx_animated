import 'package:combos/combos.dart';
import 'package:flutter/material.dart';
import 'package:mobx_animated/models/states_model.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_animated/repositories/cities_repository.dart';
import 'package:mobx_animated/repositories/states_repository.dart';

import 'models/city_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  var citiesRepository = CitiesRepository();
  GlobalKey<ListComboState> cityKey = GlobalKey<ListComboState>();

  @observable
  List<StateModel> states;

  @observable
  StateModel stateSelected;

  @action
  void selectState(StateModel stateSelected) {
    this.stateSelected = stateSelected;
  }

  @action
  void findStates() {
    this.states = StateRepository().findAllStates();
  }

  @observable
  CityModel citySelected;

  @observable
  bool loadingCities = false;

  @action
  void selectCity(CityModel city) {
    this.citySelected = city;
  }

  @action
  Future<void> findCities() async {
    loadingCities = true;
    await Future.delayed(Duration(seconds: 3));
    this.citySelected = null;
    var cities = await citiesRepository.getCitiesByState(stateSelected.id);
    loadingCities = false;
    this.cityKey.currentState.updatePopupContent(cities);
    
  }
}