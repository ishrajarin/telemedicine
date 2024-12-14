import 'package:flutter/material.dart';
import 'confirm_payment.dart';

class PharmacyListPage extends StatelessWidget {
  const PharmacyListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select your preferred pharmacy"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        scrolledUnderElevation: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          PharmacyCard(
            name: "BIG Pharmacy",
            address:
            "30A, Lintang Angsana, Mukim 13, 11500 Ayer Itam, Pulau Pinang",
            distance: "4.5km away",
            rating: 4.5,
            logo: 'assets/images/big_pharmacy.png',
          ),
          SizedBox(height: 16),
          PharmacyCard(
            name: "ALPRO Pharmacy",
            address:
            "52, Lintang Angsana, Bandar Baru Ayer Itam, 11500 Pulau Pinang",
            distance: "4.7km away",
            rating: 4.7,
            logo: 'assets/images/alpro_pharmacy.jpg',
          ),
          SizedBox(height: 16),
          PharmacyCard(
            name: "Healthy Pharmacy",
            address:
            "1-G-1, 1-G-2, Medan Angsana 3, Bandar Ayer Itam, 11500 Penang",
            distance: "5.1km away",
            rating: 4.8,
            logo: 'assets/images/healthy_pharmacy.jpg',
          ),
          SizedBox(height: 16),
          PharmacyCard(
            name: "Peoples Pharmacy",
            address:
            "92A Farlim Square Jalan Pisang Berangan Air Itam, 11500 Penang",
            distance: "6.5km away",
            rating: 4.7,
            logo: 'assets/images/peoples_pharmacy.jpg',
          ),
        ],
      ),
    );
  }
}

class PharmacyCard extends StatelessWidget {
  final String name;
  final String address;
  final String distance;
  final double rating;
  final String logo;

  const PharmacyCard({
    Key? key,
    required this.name,
    required this.address,
    required this.distance,
    required this.rating,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: const Color(0xFFDAE2FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              logo,
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        distance,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color(0xffffe234),
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the payment page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmPaymentPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA4A5FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
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
