import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_code/widgets/close_btn.dart';

import 'getDataFromAPI.dart';


class CountryItem extends StatefulWidget {
  const CountryItem({Key? key}) : super(key: key);

  @override
  State<CountryItem> createState() => _CountryItemState();
}

class _CountryItemState extends State<CountryItem> {
  late Future<List> array;
  late Future<List> arrayForDisplay;
  Future<List> upload = HttpResponse().getData();

  @override
  void initState() {
    super.initState();
    array = upload;
    arrayForDisplay = array;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Country Code",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
              CloseBtn()
            ],
          ),
          const SizedBox(height: 20),
          _searchBar(),
          Expanded(
            child: FutureBuilder<List>(
              future: array, //sets serverData as the expected Future
              builder: (context, snapshot) {
                //CounterUtil.incrementStreamCounterForLabel("futurebuilder");
                if (snapshot.hasData) {
                  //checks for non-null return value from serverData
                  return _countryItem(snapshot
                      .data); // snapshot.data is return value of serverData
                } else if (snapshot.hasError) {
                  //checks if the response threw error
                  return Text("${snapshot.error}");
                }
                return const Text("");
              },
            ),
          )
        ],
      ),
    );
  }

  _searchBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(244, 245, 255, 0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const TextField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromRGBO(89, 76, 116, 1),
          ),
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 18),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

_countryItem(List<dynamic>? array) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: ListView.builder(
      itemCount: array!.length + 1,
      itemBuilder: (BuildContext context, int index) {
        var countryName = array[index]['name'];
        var callingCode = array[index]['callingCodes'];
        var imageSrc = array[index]['flag'];

        return GestureDetector(
          onTap: () {
            print(countryName);
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 20,
                  child: FittedBox(
                      fit: BoxFit.fill, child: SvgPicture.network('$imageSrc')),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 70,
                  child: Text(
                    '+$callingCode',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(89, 76, 116, 1),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      '$countryName',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
