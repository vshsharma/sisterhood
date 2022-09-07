import 'package:flutter/material.dart';
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
  bool isShowLoader = false;
  double value = 50.0;
  void showLoader(bool showLoader) {
    setState(() {
      isShowLoader = showLoader;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    showLoader(true);
    womenShelterList = await Utils.loadJson();
    showLoader(false);
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(isShowLoader
        ? const ProgressIndicatorWidget()
        : Center(
            child: Column(
              children: [
                CustomSearchView((value) {
                  print('$value');
                }),
                CustomSlider(value),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(dim_5),
                                  child: Text(
                                    womenShelterList[index].name,
                                    style: courierFont18W600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(dim_5),
                                  child: Text(
                                    womenShelterList[index].address,
                                    style: courierFont14W600,
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      womenShelterList[index].phone.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.all(dim_5),
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
                                                    womenShelterList[index]
                                                        .phone
                                                        .replaceAll(" ", ""));
                                              },
                                              child: const SizedBox(
                                                  width: dim_35,
                                                  height: dim_35,
                                                  child: Icon(
                                                    Icons.call,
                                                    color: ColorResources.white,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: dim_5,
                                        ),
                                        Text(
                                          womenShelterList[index].phone,
                                          style: courierFont16W600,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      womenShelterList[index].email.isNotEmpty,
                                  child: Padding(
                                    padding: const EdgeInsets.all(dim_5),
                                    child: Text(
                                      womenShelterList[index].email,
                                      style: courierFont14W600,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        var coordinate = womenShelterList[index]
                                            .coordinate
                                            .split(',');
                                        Utils.navigateTo(
                                            double.parse(coordinate[0]),
                                            double.parse(coordinate[1]));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: ColorResources.darkgrey,
                                      ),
                                      icon: const Icon(Icons
                                          .directions), //icon data for elevated button
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
                                                      womenShelterList[index]
                                                          .webURL));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorResources.darkgrey,
                                        ),
                                        icon: const Icon(Icons
                                            .web), //icon data for elevated button
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
              ],
            ),
          ));
    ;
  }
}
