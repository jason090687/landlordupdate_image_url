import 'package:flutter/material.dart';
import 'package:tanle/bottom_navbar.dart';

class MySearchPage extends StatelessWidget {
  const MySearchPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: FilterWidget(),
        ),
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String activeSortButton = '';
  int selectedRating = 0;
  RangeValues _priceRangeValues = const RangeValues(500, 4000);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavBarPages()),
                    ); // Close the current screen
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ),
                const Text('Filter',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    setState(() {
                      activeSortButton = '';
                      selectedRating = 0;
                      _priceRangeValues = const RangeValues(500, 4000);
                    });
                    print('Reset button pressed');
                  },
                  child: const Text('Reset',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sort By',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                SizedBox(height: 10),
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                        hintText: '₱ Price Lower to Higher',
                        suffixIcon: Icon(Icons.arrow_drop_down, size: 40),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildRatingsSection(),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price Ranges',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                RangeSlider(
                  values: _priceRangeValues,
                  min: 500,
                  max: 4000,
                  divisions: 36,
                  onChanged: (RangeValues values) {
                    setState(() => _priceRangeValues = values);
                    print(
                        'Price range slider changed: ${values.start} - ${values.end}');
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  'Selected Range: ₱${_priceRangeValues.start.toInt()} - ₱${_priceRangeValues.end.toInt()}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Apply',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortButton(String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() => activeSortButton = label);
        print('$label button pressed');
      },
      child: Text(label,
          style: TextStyle(
              fontSize: 14,
              color: activeSortButton == label ? Colors.white : Colors.black)),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: activeSortButton == label ? Colors.blue : null,
      ),
    );
  }

  Widget _buildRatingsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 20, horizontal: 3), // Increased vertical spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ratings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 15), // Increased vertical spacing for ratings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) => _buildStarButton(index + 1)),
          ),
        ],
      ),
    );
  }

  Widget _buildStarButton(int number) {
    return ElevatedButton(
      onPressed: () {
        setState(
            () => selectedRating = (selectedRating == number) ? 0 : number);
        print('Star button $number pressed');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: (selectedRating == number) ? Colors.blue : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.star,
              color: Colors.yellow, size: 18), // Increased size of stars
          const SizedBox(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            child: Text(
              number.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color:
                      (selectedRating == number) ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
