import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Records').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot<Map<String, dynamic>>>? paymentData =
              snapshot.data!.docs;
          return ListView.builder(
            itemCount: paymentData.length,
            itemBuilder: (context, index) {
              var payment = paymentData[index].data();
              var price = payment['Price'] ?? '';
              var name = payment['Name'] ?? '';
              var cardUsed = payment['checkindate'] ?? '';

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Name: $name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: $price'),
                      Text('time: $cardUsed'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
