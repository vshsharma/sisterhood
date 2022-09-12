import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sisterhood_app/location/location_util.dart';
import 'package:sisterhood_app/screen/app_widgets/search_view.dart';
import 'package:sisterhood_app/screen/app_widgets/slider.dart';
import 'package:sisterhood_app/screen/women_shelter/model/women_shelter_model.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/strings.dart';
import 'package:sisterhood_app/utill/utils.dart';

import '../../utill/dimension.dart';
import '../../utill/styles.dart';
import '../app_widgets/progress_indicator.dart';
import '../common/base_widget.dart';

class WomenShelterScreen extends StatefulWidget {
  const WomenShelterScreen({Key key}) : super(key: key);

  @override
  State<WomenShelterScreen> createState() => _WomenShelterScreenState();
}

class _WomenShelterScreenState extends State<WomenShelterScreen> {
  List<WomenShelterModel> womenShelterList = [];
  List<WomenShelterModel> items = [];
  TextEditingController textEditingController = TextEditingController();
  bool isShowLoader = false;
  double value = 20000.0;
  void showLoader(bool showLoader) {
    setState(() {
      isShowLoader = showLoader;
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    showLoader(true);
    bool isLocationPermission = await LocationUtil.locationPermission();
    if (isLocationPermission) {
      Position resultCoordinates = await LocationUtil.getCoordinates();
      loadData(resultCoordinates);
      print("Latitude: ${resultCoordinates.latitude}");
      print("Longitude: ${resultCoordinates.longitude}");
    }
  }

  Future<void> loadData(Position resultCoordinates) async {
    showLoader(true);
    var jsonList = await Utils.loadJson();
    print("Selected Distance: $value");
    var loadedData = jsonList
        .where((element) =>
            distanceBetweenCoordinates(element, resultCoordinates) < value)
        .toList();
    items.clear();
    womenShelterList.clear();
    items.addAll(loadedData);
    womenShelterList.addAll(loadedData);
    showLoader(false);
  }

  double distanceBetweenCoordinates(
      WomenShelterModel element, Position resultCoordinates) {
    double distanceFromCurrentLocation =
        LocationUtil.getDistanceBetweenCoordinates(
            Position(
              latitude: double.parse(element.coordinate.split(',')[0]),
              longitude: double.parse(element.coordinate.split(',')[1]),
              speed: 0.0,
              heading: 0.0,
              accuracy: 0.0,
              timestamp: DateTime.now(),
              speedAccuracy: 0.0,
              altitude: 0.0,
            ),
            resultCoordinates);
    Utils.log("distanceFromCurrentLocation: $distanceFromCurrentLocation");
    return distanceFromCurrentLocation;
  }

  void filterSearchResults(String query) {
    List<WomenShelterModel> tempList = [];
    tempList.addAll(items);
    if (query.trim().isNotEmpty) {
      List<WomenShelterModel> dummyListData = [];
      dummyListData = tempList
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        womenShelterList.clear();
        womenShelterList.addAll(dummyListData);
      });
    } else {
      setState(() {
        womenShelterList.clear();
        womenShelterList.addAll(items);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(isShowLoader
        ? const ProgressIndicatorWidget()
        : Center(
            child: womenShelterList.isNotEmpty
                ? Column(
                    children: [
                      CustomSearchView((value) {
                        filterSearchResults(value);
                      }, textEditingController),
                      Expanded(
                        child: ListView.builder(
                            itemCount: womenShelterList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                semanticContainer: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Padding(
                                  padding: const EdgeInsets.all(dim_8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(dim_2),
                                        child: Text(
                                          womenShelterList[index].name,
                                          style: courierFont18W600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(dim_2),
                                        child: Text(
                                          womenShelterList[index].address,
                                          style: courierFont14W600,
                                        ),
                                      ),
                                      Visibility(
                                        visible: womenShelterList[index]
                                            .email
                                            .isNotEmpty,
                                        child: Padding(
                                          padding: const EdgeInsets.all(dim_5),
                                          child: Text(
                                            womenShelterList[index]
                                                .email
                                                .toLowerCase(),
                                            style: courierFont14W600,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: womenShelterList[index]
                                            .phone
                                            .isNotEmpty,
                                        child: Padding(
                                          padding: const EdgeInsets.all(dim_2),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipOval(
                                                child: Material(
                                                  color: ColorResources
                                                      .darkgrey, // Button color
                                                  child: InkWell(
                                                    splashColor: ColorResources
                                                        .green, // Splash color
                                                    onTap: () {
                                                      Utils.makePhoneCall(
                                                          womenShelterList[
                                                                  index]
                                                              .phone
                                                              .replaceAll(
                                                                  " ", ""));
                                                    },
                                                    child: const SizedBox(
                                                        width: dim_30,
                                                        height: dim_30,
                                                        child: Icon(
                                                          Icons.call,
                                                          size: dim_20,
                                                          color: ColorResources
                                                              .white,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: dim_5,
                                              ),
                                              Text(
                                                womenShelterList[index]
                                                    .phone
                                                    .replaceAll(" ", ""),
                                                style: courierFont16W600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              var coordinate =
                                                  womenShelterList[index]
                                                      .coordinate
                                                      .split(',');
                                              Utils.navigateTo(
                                                  double.parse(coordinate[0]),
                                                  double.parse(coordinate[1]));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: ColorResources.darkgrey,
                                            ),
                                            icon: const Icon(
                                              Icons.directions,
                                              color: ColorResources.white,
                                            ), //icon data for elevated button
                                            label: const Text(
                                                Strings.direction), //label text
                                          ),
                                          Visibility(
                                            visible: womenShelterList[index]
                                                .webURL
                                                .isNotEmpty,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                Utils
                                                    .launchInWebViewWithoutJavaScript(
                                                        Uri.parse(
                                                            womenShelterList[
                                                                    index]
                                                                .webURL));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    ColorResources.darkgrey,
                                              ),
                                              icon: const Icon(Icons.web,
                                                  color: ColorResources
                                                      .white), //icon data for elevated button
                                              label: const Text(
                                                  Strings.website), //label text
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(dim_10),
                                ),
                                elevation: dim_5,
                                margin: const EdgeInsets.all(dim_5),
                              );
                            }),
                      ),
                      CustomSlider(value, (distance) {
                        value = distance;
                        Utils.log('Update distance: $distance');
                        getLocation();
                      }),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        Strings.no_shelter,
                        style: courierFont25W700Black,
                      ),
                      CustomSlider(value, (distance) {
                        value = distance;
                        Utils.log('Update distance: $distance');
                        getLocation();
                      }),
                    ],
                  ),
          ));
    ;
  }
}
