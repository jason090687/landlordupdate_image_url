import 'package:flutter/material.dart';
import 'package:tanle/components/boarding_list.dart';

class AminitiesTile extends StatelessWidget {
  final Amenity amenity;
  const AminitiesTile({
    super.key,
    required this.amenity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(26, 202, 199, 199)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 226, 225, 225).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 5),
            )
          ]),
      width: 250,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              amenity.imgPath,
              height: 150,
              width: 2500,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    amenity.internet,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    amenity.aminity,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
