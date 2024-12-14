import 'package:flutter/material.dart';
import 'package:tele_medicine/confirm_popup.dart';

class ConfirmPaymentPage extends StatefulWidget {
  const ConfirmPaymentPage({Key? key}) : super(key: key);
  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<ConfirmPaymentPage> {
  String selectedPaymentMethod = 'Credit Card / Debit Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Payment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        scrolledUnderElevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Payment Method',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            PaymentMethodTile(
              value: 'Credit Card / Debit Card',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              logo: 'assets/images/credit_card.png',
            ),
            const SizedBox(height: 8),
            PaymentMethodTile(
              value: 'FPX Payment',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              logo: 'assets/images/fpx.png',
            ),
            const SizedBox(height: 8),
            PaymentMethodTile(
              value: 'PayPal',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              logo: 'assets/images/paypal.png',
            ),
            const SizedBox(height: 8),
            PaymentMethodTile(
              value: 'Google Pay',
              groupValue: selectedPaymentMethod,
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              },
              logo: 'assets/images/google_pay.png',
            ),
            // const SizedBox(height: 8),
            // PaymentMethodTile(
            //   value: 'Cash on Delivery',
            //   groupValue: selectedPaymentMethod,
            //   onChanged: (value) {
            //     setState(() {
            //       selectedPaymentMethod = value!;
            //     });
            //   },
            //   logo: 'assets/images/cash.png',
            // ),
            const Spacer(),
            const Text('Items Purchased',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            // const ItemRow(name: "500mg 30 capsules Amoxicillin", price: 100.25),
            // const ItemRow(name: "500mg 10 tablets Metformin", price: 65.25),
            const ItemRow(name: "Consultation Fee", price: 50.00),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text('Confirm Your Payment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const PaymentSummary(
              subTotal: 50.00,
              transactionFee: 2.50,
              totalPayment: 52.50,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement API call to payment page here

                // Navigate to the payment success page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScheduledPopup(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA4A5FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Center(
                child: Text('Confirm Payment',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final String name;
  final double price;

  const ItemRow({Key? key, required this.name, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 14)),
          Text('RM${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  final String logo;

  const PaymentMethodTile(
      {Key? key,
        required this.value,
        required this.groupValue,
        required this.onChanged,
        required this.logo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value); // Trigger the onChanged callback with the value
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: value == groupValue
                ? const Color(0xFFA4A5FF)
                : const Color(0xAA757575), // Border color
            width: 1.5, // Border width
          ),
          borderRadius: BorderRadius.circular(8.0), // Optional: Border radius
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          title: Text(value),
          trailing: Image.asset(logo, height: 30),
        ),
      ),
    );
  }
}

class PaymentSummary extends StatelessWidget {
  final double subTotal;
  final double? shippingFee;
  final double? transactionFee;
  final double totalPayment;

  const PaymentSummary(
      {Key? key,
        required this.subTotal,
        this.shippingFee,
        this.transactionFee,
        required this.totalPayment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SummaryRow(label: 'Sub-Total', value: subTotal),
        if (transactionFee != null)
          SummaryRow(label: 'Transaction Fee', value: transactionFee!),
        if (shippingFee != null)
          SummaryRow(label: 'Shipping Fee', value: shippingFee!),
        SummaryRow(label: 'Total Payment', value: totalPayment, isTotal: true),
      ],
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const SummaryRow(
      {Key? key,
        required this.label,
        required this.value,
        this.isTotal = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(
            'RM${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              color: isTotal
                  ? const Color.fromARGB(255, 217, 0, 255)
                  : Colors.black,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
