import 'package:flutter/material.dart';
import 'package:tele_medicine/order_tracking.dart';
import 'pharmacy_list.dart';
import '/models/user.dart';
import 'rate_order.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ManagePrescription extends StatefulWidget {
  const ManagePrescription({Key? key}) : super(key: key);

  @override
  ManagePrescriptionState createState() => ManagePrescriptionState();
}

class ManagePrescriptionState extends State<ManagePrescription> {
  // Fetch username
  String? displayName = UserCredentials().displayName;

  final GlobalKey _menuKey = GlobalKey();

  bool _isCardTapped = false;
  int? _selectedCardIndex;
  late List<Widget> widgetOptions;

  @override
  void initState() {
    super.initState();
    widgetOptions = <Widget>[
      _buildPrescriptionDetailsCard1(),
      _buildPrescriptionDetailsCard2(),
      _buildPrescriptionDetailsCard3(),
    ];
  }

  void _showPopupMenu() {
    final RenderBox? renderBox =
    _menuKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          position.dx,
          position.dy + size.height,
          position.dx + size.width,
          position.dy,
        ),
        items: [
          const PopupMenuItem<String>(
            value: 'date',
            child: Text('Date'),
          ),
          const PopupMenuItem<String>(
            value: 'status',
            child: Text('Status'),
          ),
          const PopupMenuItem<String>(
            value: 'doctor',
            child: Text('Doctor'),
          ),
          const PopupMenuItem<String>(
            value: 'id',
            child: Text('ID'),
          ),
          const PopupMenuItem<String>(
            value: 'no_of_medicines',
            child: Text('No of Medicines'),
          ),
        ],
      ).then((value) {
        if (value != null) {
          // Handle the selected value
          print('Selected: $value');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isCardTapped
          ? _buildOriginalContent()
          : widgetOptions[_selectedCardIndex!],
    );
  }

  Widget _buildOriginalContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Filter Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '$displayName\'s Prescriptions Purchase Records',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton.icon(
                key: _menuKey,
                onPressed: () {
                  // Call dropdown menu
                  _showPopupMenu();
                },
                icon: const Icon(Icons.filter_alt_rounded),
                label: const Text('Filter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA4A5FF),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // List of Prescription Records
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    // Handle the tap event
                    setState(() {
                      _isCardTapped = true;
                      _selectedCardIndex = 0;
                    });
                  },
                  child: _buildPrescriptionCard(
                    context,
                    backgroundColor: Colors.red[100],
                    statusColor: const Color(0xFFB22222),
                    statusText: "Incomplete",
                    prescriptionNumber: "#WE123121",
                    date: "30-April-2024",
                    doctorName: "Dr. Jane Smith",
                    hospital: "Hospital Lam Wah Ee",
                    licenseNumber: "123456",
                    contact: "011-2134 9824",
                    totalTypes: 2,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle the tap event
                    setState(() {
                      _isCardTapped = true;
                      _selectedCardIndex = 1;
                    });
                  },
                  child: _buildPrescriptionCard(
                    context,
                    backgroundColor: Colors.yellow[100],
                    statusColor: const Color(0xFFFFA500),
                    statusText: "Ongoing",
                    prescriptionNumber: "#IH232211",
                    date: "28-March-2024",
                    doctorName: "Dr. Lebron James",
                    hospital: "Island Hospital",
                    licenseNumber: "654321",
                    contact: "011-792 3699",
                    totalTypes: 2,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle the tap event
                    setState(() {
                      _isCardTapped = true;
                      _selectedCardIndex = 2;
                    });
                  },
                  child: _buildPrescriptionCard(
                    context,
                    backgroundColor: Colors.green[100],
                    statusColor: const Color(0xFF247B7B),
                    statusText: "Completed",
                    prescriptionNumber: "#IH241432",
                    date: "10-January-2024",
                    doctorName: "Dr. Lebron James",
                    hospital: "Island Hospital",
                    licenseNumber: "654321",
                    contact: "011-792 3699",
                    totalTypes: 3,
                  ),
                )
              ],
            ),
          ),

          // No More Results Message
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "-- No more results --",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrescriptionCard(
      BuildContext context, {
        Color? backgroundColor,
        Color? statusColor,
        required String statusText,
        required String prescriptionNumber,
        required String date,
        required String doctorName,
        required String hospital,
        required String licenseNumber,
        required String contact,
        required int totalTypes,
      }) {
    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prescription Number and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prescriptionNumber,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Doctor Information
            Text(
              "$doctorName, MD ($hospital)",
              style: const TextStyle(fontSize: 14.0),
            ),
            Text(
              "Medical License No.: $licenseNumber",
              style: const TextStyle(fontSize: 14.0),
            ),
            Text(
              "Contact: $contact",
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(height: 8.0),

            // Total Types of Medicines and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total types of medicines: $totalTypes",
                  style: const TextStyle(fontSize: 14.0),
                ),
                Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: statusColor, // Adjust this color as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionDetailsCard1() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), // Set the height you want
        child: Container(
          padding:
          const EdgeInsets.only(top: 10.0), // Set the top padding you want
          child: AppBar(
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  _isCardTapped = false;
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Colors
                      .red[100], // Light red background color for the card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Prescription ID and Status
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#WE123121',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Status: Incomplete',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFFB22222),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // Patient's Information
                        const Text(
                          "Patient's Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Full Name: Mr. XYZ'),
                        const Text('IC: 950213-07-0123'),
                        const Text('Contact: 012-3456 7890'),
                        const SizedBox(height: 16.0),
                        // Prescriber's Information
                        const Text(
                          "Prescriber's Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Full Name: Dr. Jane Smith'),
                        const Text('Medical License No.: 123456'),
                        const Text('Contact: 011-2134 9824'),
                        const Text('Hospital Name: Hospital Lam Wah Ee'),
                        const SizedBox(height: 16.0),
                        // Prescription Details
                        const Text(
                          'Prescription Details',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Date of Prescription: 30-April-2024'),
                        const SizedBox(height: 16.0),
                        // Medication Details Table
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                            defaultColumnWidth: const FixedColumnWidth(150.0),
                            border: TableBorder.all(color: Colors.black),
                            children: const [
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Medication Name',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Dosage',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Instruction For Use',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Duration of Prescription',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Amoxicillin'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('500mg, 30 capsules'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Take 1 capsule orally every 8 hours'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('10 days'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Metformin'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('500mg, 10 tablets'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Take 1 tablet twice daily after meals'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('5 days'),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Disclaimer
                        const Text(
                          'Disclaimer:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        HtmlWidget('''
                        <p style="text-align: justify; font-size: 12px; color: #757575;">
                          The information provided in this prescription is intended for the use of the prescribed patient only. It is based on the clinical judgment of the prescriber, who has evaluated the patient's specific medical condition and needs. The prescriber has considered potential benefits and risks associated with the prescribed medications. Patients are advised to follow the dosage and administration instructions as outlined in the prescription. It is essential to complete the full course of medication as directed, even if symptoms improve before the medication is finished. Do not alter the prescribed dosage or discontinue use without consulting the prescriber. Potential side effects, interactions with other medications, and contraindications have been considered to the best of the prescriber's knowledge. However, patients should immediately report any unexpected reactions or adverse effects to the prescriber or seek emergency medical attention if necessary. This prescription is intended solely for the patient named and should not be shared with others. Unauthorized use of this prescription by individuals other than the prescribed patient can be harmful and is prohibited. The prescriber is not responsible for the misuse, incorrect use, or non-compliance with the instructions provided. For any questions or concerns regarding the medication or its administration, patients should contact the prescriber directly. By accepting this prescription, the patient acknowledges understanding and acceptance of these terms.
                        </p>
                        '''),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PharmacyListPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10.0),
                    backgroundColor: const Color(0xFFA4A5FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  child: const Text('Delivery Now',
                      style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PharmacyListPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10.0),
                    backgroundColor: const Color(0xFFA4A5FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  child: const Text('Self Pickup',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionDetailsCard2() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), // Set the height you want
        child: Container(
          padding:
          const EdgeInsets.only(top: 10.0), // Set the top padding you want
          child: AppBar(
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  _isCardTapped = false;
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Colors.yellow[
                  100], // Light orange background color for the card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Prescription ID and Status
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#IH232211',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Status: Ongoing',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFFFFA500),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // Patient's Information
                        const Text(
                          "Patient's Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Full Name: Mr. XYZ'),
                        const Text('IC: 950213-07-0123'),
                        const Text('Contact: 012-3456 7890'),
                        const SizedBox(height: 16.0),
                        // Prescriber's Information
                        const Text(
                          "Prescriber's Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Full Name: Dr. Lebron James'),
                        const Text('Medical License No.: 654321'),
                        const Text('Contact: 011-792 3699'),
                        const Text('Hospital Name: Island Hospital'),
                        const SizedBox(height: 16.0),
                        // Prescription Details
                        const Text(
                          'Prescription Details',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Date of Prescription: 28-March-2024'),
                        const SizedBox(height: 16.0),
                        // Medication Details Table
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                            defaultColumnWidth: const FixedColumnWidth(150.0),
                            border: TableBorder.all(color: Colors.black),
                            children: const [
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Medication Name',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Dosage',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Instruction For Use',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Duration of Prescription',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Amoxicillin'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('500mg, 30 capsules'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Take 1 capsule orally every 8 hours'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('10 days'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Metformin'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('500mg, 10 tablets'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Take 1 tablet twice daily after meals'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('5 days'),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Disclaimer
                        const Text(
                          'Disclaimer:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        HtmlWidget('''
                        <p style="text-align: justify; font-size: 12px; color: #757575;">
                          The information provided in this prescription is intended for the use of the prescribed patient only. It is based on the clinical judgment of the prescriber, who has evaluated the patient's specific medical condition and needs. The prescriber has considered potential benefits and risks associated with the prescribed medications. Patients are advised to follow the dosage and administration instructions as outlined in the prescription. It is essential to complete the full course of medication as directed, even if symptoms improve before the medication is finished. Do not alter the prescribed dosage or discontinue use without consulting the prescriber. Potential side effects, interactions with other medications, and contraindications have been considered to the best of the prescriber's knowledge. However, patients should immediately report any unexpected reactions or adverse effects to the prescriber or seek emergency medical attention if necessary. This prescription is intended solely for the patient named and should not be shared with others. Unauthorized use of this prescription by individuals other than the prescribed patient can be harmful and is prohibited. The prescriber is not responsible for the misuse, incorrect use, or non-compliance with the instructions provided. For any questions or concerns regarding the medication or its administration, patients should contact the prescriber directly. By accepting this prescription, the patient acknowledges understanding and acceptance of these terms.
                        </p>
                        '''),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Check delivery status
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderTrackingPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10.0),
                    backgroundColor: const Color(0xFFA4A5FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  child: const Text('Check Delivery Status',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionDetailsCard3() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), // Set the height you want
        child: Container(
          padding:
          const EdgeInsets.only(top: 10.0), // Set the top padding you want
          child: AppBar(
            scrolledUnderElevation: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  _isCardTapped = false;
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Colors
                      .green[100], // Light green background color for the card
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Prescription ID and Status
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#IH241432',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Status: Completed',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF247B7B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // Patient's Information
                        const Text(
                          "Patient's Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Full Name: Mr. XYZ'),
                        const Text('IC: 950213-07-0123'),
                        const Text('Contact: 012-3456 7890'),
                        const SizedBox(height: 16.0),
                        // Prescriber's Information
                        const Text(
                          "Prescriber's Information",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Full Name: Dr. Lebron James'),
                        const Text('Medical License No.: 654321'),
                        const Text('Contact: 011-792 3699'),
                        const Text('Hospital Name: Island Hospital'),
                        const SizedBox(height: 16.0),
                        // Prescription Details
                        const Text(
                          'Prescription Details',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const Text('Date of Prescription: 10-January-2024'),
                        const SizedBox(height: 16.0),
                        // Medication Details Table
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                            defaultColumnWidth: const FixedColumnWidth(150.0),
                            border: TableBorder.all(color: Colors.black),
                            children: const [
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Medication Name',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Dosage',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Instruction For Use',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Duration of Prescription',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Amoxicillin'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('500mg, 30 capsules'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Take 1 capsule orally every 8 hours'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('10 days'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Metformin'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('500mg, 10 tablets'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                      'Take 1 tablet twice daily after meals'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('5 days'),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Paracetamol'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('500mg, 20 tablets'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child:
                                  Text('Take 1-2 tablets every 4-6 hours'),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('3 days'),
                                ),
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        // Disclaimer
                        const Text(
                          'Disclaimer:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8.0),
                        HtmlWidget('''
                        <p style="text-align: justify; font-size: 12px; color: #757575;">
                          The information provided in this prescription is intended for the use of the prescribed patient only. It is based on the clinical judgment of the prescriber, who has evaluated the patient's specific medical condition and needs. The prescriber has considered potential benefits and risks associated with the prescribed medications. Patients are advised to follow the dosage and administration instructions as outlined in the prescription. It is essential to complete the full course of medication as directed, even if symptoms improve before the medication is finished. Do not alter the prescribed dosage or discontinue use without consulting the prescriber. Potential side effects, interactions with other medications, and contraindications have been considered to the best of the prescriber's knowledge. However, patients should immediately report any unexpected reactions or adverse effects to the prescriber or seek emergency medical attention if necessary. This prescription is intended solely for the patient named and should not be shared with others. Unauthorized use of this prescription by individuals other than the prescribed patient can be harmful and is prohibited. The prescriber is not responsible for the misuse, incorrect use, or non-compliance with the instructions provided. For any questions or concerns regarding the medication or its administration, patients should contact the prescriber directly. By accepting this prescription, the patient acknowledges understanding and acceptance of these terms.
                        </p>
                        '''),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RateOrder()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 10.0),
                    backgroundColor: const Color(0xFFA4A5FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                  ),
                  child:
                  const Text('Rate', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
