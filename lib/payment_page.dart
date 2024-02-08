import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanle/End_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  String totalPrice = '₱ 0.00'; // Default value

  @override
  void dispose() {
    cardHolderNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection('Records').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.docs.isEmpty) {
            return const Text('Document does not exist');
          } else {
            var total = snapshot.data!.docs.first.get('total');
            totalPrice = '₱ ${total!.toStringAsFixed(2) ?? '0.00'}';

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: 500,
                        height: 150,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: const Color.fromRGBO(215, 235, 252, 100),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Total Price:',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              totalPrice,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Payment method',
                                style: TextStyle(fontSize: 20)),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/Gcash.png',
                                  width: 55,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 13),
                                Image.asset(
                                  'assets/images/BDO.png',
                                  width: 55,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 13),
                                Image.asset(
                                  'assets/images/paypal.png',
                                  width: 55,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(width: 13),
                                Image.asset(
                                  'assets/images/paymaya.png',
                                  width: 55,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            buildTextField('Card Holder Name'),
                            const SizedBox(height: 10),
                            buildTextField('Card Number'),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildTextField('Expiry date (MM/YY)',
                                    width: 150),
                                const SizedBox(width: 10),
                                buildTextField('CVV', width: 100),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Row(
                          children: [
                            Text(
                              'Strictly NO REFUND ****',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Call a function to insert payment data into Firebase
                          insertPaymentData();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          side:
                              const BorderSide(color: Colors.blue, width: 2.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: const Center(
                            child: Text(
                              'PAY NOW',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildTextField(String label, {double? width}) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: (label == 'Card Holder Name')
            ? cardHolderNameController
            : (label == 'Card Number')
                ? cardNumberController
                : (label == 'Expiry date (MM/YY)')
                    ? expiryDateController
                    : cvvController,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }

  // Function to insert payment data into Firebase
  void insertPaymentData() async {
    try {
      await _firestore.collection('payments').add({
        'cardHolderName': cardHolderNameController.text,
        'cardNumber': cardNumberController.text,
        'expiryDate': expiryDateController.text,
        'cvv': cvvController.text,
      });

      // Navigate to the end page after successful payment
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyEndPage()),
      );
    } catch (e) {
      // Handle errors here
      print('Error inserting payment data: $e');
      // You might want to show a user-friendly error message here
    }
  }
}
