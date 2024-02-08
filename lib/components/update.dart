import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBoardDetailsScreen extends StatefulWidget {
  final String documentId;

  const EditBoardDetailsScreen({Key? key, required this.documentId})
      : super(key: key);

  @override
  _EditBoardDetailsScreenState createState() =>
      _EditBoardDetailsScreenState(documentId);
}

class _EditBoardDetailsScreenState extends State<EditBoardDetailsScreen> {
  final String documentId;
  late TextEditingController boardingHouseNameController;
  late TextEditingController discountController;
  // Add controllers for other fields as needed

  _EditBoardDetailsScreenState(this.documentId);

  @override
  void initState() {
    super.initState();
    boardingHouseNameController = TextEditingController();
    discountController = TextEditingController();
    // Initialize other controllers and fetch data from Firebase
    fetchData();
  }

  void fetchData() async {
    // Fetch data from Firebase using the documentId
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Records')
        .doc(documentId)
        .get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;

      setState(() {
        boardingHouseNameController.text = data['Name'] ?? '';
        discountController.text = data['Discount'] ?? '';
        // Set other controllers and fields
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Boarding House Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: boardingHouseNameController,
              decoration: InputDecoration(labelText: 'Boarding House Name'),
            ),
            TextFormField(
              controller: discountController,
              decoration: InputDecoration(labelText: 'Discount'),
            ),
            // Add other input fields for the remaining data
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateData();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void updateData() async {
    // Update data in Firebase using the documentId
    await FirebaseFirestore.instance
        .collection('Records')
        .doc(documentId)
        .update({
      'Name': boardingHouseNameController.text,
      'Discount': discountController.text,
      // Update other fields as needed
    });

    // Navigate back to the details screen
    Navigator.pop(context);
  }
}
