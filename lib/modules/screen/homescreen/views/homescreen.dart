import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_flutter_api/utils/helpers/apihelpers.dart';
import '../../../../utils/model/api_model.dart';
import '../Provider/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = "Surat";
  TextEditingController textEditingController = TextEditingController();
  bool isTextFieldFocused = false;

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            (Provider.of<themeprovider>(context, listen: true).theme.isdark ==
                    true)
                ? Colors.blue.shade100
                : Colors.black,
        title: TextField(
          onTap: () {
            setState(() {
              isTextFieldFocused = true;
            });
          },
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: 'Enter city name',
            border: OutlineInputBorder(
              borderSide: const BorderSide(),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.search,
            color: (Provider.of<themeprovider>(context, listen: true)
                        .theme
                        .isdark ==
                    true)
                ? Colors.black
                : Colors.white,
          ),
          onPressed: () {
            fetchWeatherData();
          },
        ),
      ),
      body: FutureBuilder(
        future: Apihelper.api.getdata(search: title),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            api_model? apiModel = snapshot.data;
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        (Provider.of<themeprovider>(context, listen: true)
                                    .theme
                                    .isdark ==
                                true)
                            ? "https://as2.ftcdn.net/v2/jpg/03/90/75/29/1000_F_390752987_7GEo92X2o9OcNNOQqP9AsscrkRxuG1zE.jpg"
                            : "https://i.pinimg.com/736x/82/81/74/828174be3b112bd956cae5ead06500aa.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),
                    ),
                    color: (Provider.of<themeprovider>(context, listen: true)
                                .theme
                                .isdark ==
                            true)
                        ? Colors.blue.shade100
                        : Colors.black,
                  ),
                  height: 20,
                  width: double.infinity,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: (Provider.of<themeprovider>(context,
                                            listen: true)
                                        .theme
                                        .isdark ==
                                    true)
                                ? Colors.blue.shade800
                                : Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${apiModel?.location['name']}, ${apiModel?.location['country']}",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: (Provider.of<themeprovider>(context,
                                              listen: true)
                                          .theme
                                          .isdark ==
                                      true)
                                  ? Colors.blue.shade800
                                  : Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Provider.of<themeprovider>(context, listen: false)
                                  .changetheme();
                            },
                            icon: Icon(
                                (Provider.of<themeprovider>(context,
                                                listen: true)
                                            .theme
                                            .isdark ==
                                        true)
                                    ? Icons.bedtime_sharp
                                    : Icons.sunny,
                                color: (Provider.of<themeprovider>(context,
                                                listen: true)
                                            .theme
                                            .isdark ==
                                        true)
                                    ? Colors.blue.shade800
                                    : Colors.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          "Today, ${apiModel?.forecast['forecastday'][0]['date']}",
                          style: TextStyle(
                              color: (Provider.of<themeprovider>(context,
                                              listen: true)
                                          .theme
                                          .isdark ==
                                      true)
                                  ? Colors.blue.shade800
                                  : Colors.white,
                              fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          "${apiModel?.current['temp_c']}℃",
                          style: TextStyle(
                            fontSize: 35,
                            color: (Provider.of<themeprovider>(context,
                                            listen: true)
                                        .theme
                                        .isdark ==
                                    true)
                                ? Colors.blue.shade800
                                : Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        // Set a fixed height
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Feelslike",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const Text("℃",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white)),
                                Text(
                                  "${apiModel?.current['feelslike_c']}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Wind",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const Icon(
                                  Icons.air,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${apiModel?.current['wind_kph']}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Cloud",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const Icon(
                                  Icons.cloud,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${apiModel?.current['cloud']}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "Humidity",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                const Icon(
                                  Icons.water_drop,
                                  color: Colors.white,
                                ),
                                Text(
                                  "${apiModel?.current['humidity']}",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (!isTextFieldFocused)
                        Expanded(
                          flex: 2,
                          child: ListView.builder(
                            itemCount: 24,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Container(
                              height: 100,
                              width: 100,
                              margin: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${index} : 00",
                                    style: const TextStyle(
                                        fontSize: 17, color: Colors.white),
                                  ),
                                  Image.network(
                                    "http:${apiModel?.forecast['forecastday'][0]['hour'][index]['condition']['icon']}",
                                  ),
                                  Text(
                                    "${apiModel?.forecast['forecastday'][0]['hour'][index]['temp_c']} ℃",
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Container(
              height: 400,
              width: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://cdn.dribbble.com/users/205136/screenshots/2582152/ae-fun.gif",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void fetchWeatherData() {
    String enteredCity = textEditingController.text;
    if (enteredCity.isNotEmpty) {
      setState(() {
        title = enteredCity;
      });
    }
  }
}
