import 'package:flutter/material.dart';
import "ai_chatbot.dart";
import 'booking_consultation.dart';
import 'message_detail.dart';

class Consultation extends StatefulWidget {
  const Consultation({Key? key}) : super(key: key);

  @override
  ConsultationState createState() => ConsultationState();
}

class ConsultationState extends State<Consultation> {
  bool isFavorite1 = true;
  bool isFavorite2 = false;

  bool viewAllAppointments = false;

  bool isCardTapped = false;
  int? _selectedIndex;
  late List<Widget> widgetOptions;

  @override
  void initState() {
    super.initState();
    widgetOptions = <Widget>[
      _buildDoctorDetailsCard1(),
      _buildDoctorDetailsCard2(),
    ];
  }

  void _changeShowAppointment() {
    setState(() {
      viewAllAppointments = !viewAllAppointments;
    });
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate == null) return;

    if (!context.mounted) return;

    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return;

    DateTime finalDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(
          selectedDateTime: finalDateTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isCardTapped && !viewAllAppointments
          ? consultationHome()
          : viewAllAppointments
          ? _showAllAppointments()
          : widgetOptions.elementAt(_selectedIndex!),
    );
  }

  Widget consultationHome() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor image section
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Doctor Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      'assets/images/doctorconsultation1.jpg', // Replace with your image asset path
                      width: 140,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Text and Button Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Not sure which specialist to find?',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Gemini can help!',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChatAI()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA4A5FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 12.0),
                            child: Text(
                              'Ask Gemini',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Buttons: Saved, Manage Appointment, Message
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 18.0), // Add horizontal padding
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(
                    icon: Icons.bookmark,
                    label: 'Saved',
                    color: Colors.orange,
                  ),
                  GestureDetector(
                    onTap: () {
                      _changeShowAppointment();
                    },
                    child: _buildIconButton(
                      icon: Icons.calendar_today,
                      label: 'Manage Appointment',
                      color: Colors.red,
                    ),
                  ),
                  _buildIconButton(
                    icon: Icons.message,
                    label: 'Message',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 16.0), // Add padding at the bottom
                  child: Column(
                    children: [
                      // Doctor cards
                      GestureDetector(
                        onTap: () => setState(() {
                          isCardTapped = true;
                          _selectedIndex = 0;
                        }),
                        child: _buildDoctorCard(
                          imageUrl: "assets/images/doctorconsultation2.jpg",
                          name: 'Dr. Lebron James',
                          specialty: 'Physician',
                          experience: '8 Years experience',
                          rating: '95%',
                          patientStories: '82 Patient Stories',
                          nextAvailable: '12:00 AM tomorrow',
                          isFavorite: isFavorite1,
                          onPressed: () {
                            setState(() {
                              isFavorite1 = !isFavorite1;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => setState(() {
                          isCardTapped = true;
                          _selectedIndex = 1;
                        }),
                        child: _buildDoctorCard(
                          imageUrl: "assets/images/doctorconsultation3.jpg",
                          name: 'Dr. Jane Smith',
                          specialty: 'Specialist medicine',
                          experience: '6 Years experience',
                          rating: '87%',
                          patientStories: '60 Patient Stories',
                          nextAvailable: '10:00 AM tomorrow',
                          isFavorite: isFavorite2,
                          onPressed: () {
                            setState(() {
                              isFavorite2 = !isFavorite2;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }

  Widget _buildDoctorCard({
    required String name,
    required String specialty,
    required String experience,
    required String rating,
    required String patientStories,
    required String nextAvailable,
    required String imageUrl,
    required bool isFavorite,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: const Color(0xFFE8F0FF),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    specialty,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    experience,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700], size: 16),
                          const SizedBox(width: 4),
                          Text(rating,
                              style: const TextStyle(
                                fontSize: 10,
                              )),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Text(patientStories,
                          style: const TextStyle(
                            fontSize: 10,
                          )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Next Available: $nextAvailable',
                    style: const TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onPressed,
                ),
                const SizedBox(height: 45),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _selectDateTime(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA4A5FF),
                          elevation: 0, // No elevation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20), // Optional: rounded corners
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _showAllAppointments() {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: const Text('All Appointments', textAlign: TextAlign.center),
          centerTitle: true, // Center the title
          leading: Padding(
            padding:
            const EdgeInsets.only(left: 8.0), // Adjust the value as needed
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                _changeShowAppointment();
              },
            ),
          ),
          leadingWidth: 45.0, // Adjust the width as needed
          titleSpacing: 0.0, // Ensure no extra spacing
        ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildAppointmentCard(
                  imageUrl: "assets/images/doctor.png",
                  name: 'Dr. Afna Khan',
                  bookingID: '2132CaB',
                  date: '29th Aug 2024 (Fri)',
                  time: '5:00PM',
                  duration: '30mins',
                ),
                _buildAppointmentCard(
                  imageUrl: "assets/images/doctorconsultation3.jpg",
                  name: 'Dr. Lebron James',
                  bookingID: '1234aBc',
                  date: '2nd Sep 2024 (Mon)',
                  time: '11:00AM',
                  duration: '30mins',
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildAppointmentCard({
    required String name,
    required String bookingID,
    required String date,
    required String time,
    required String duration,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0xAADAE2FF),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$date, $time ($duration)',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(imageUrl),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.video_call,
                        color: Colors.blue,
                        size: 24.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Booking id: #$bookingID',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () {
                  // Handle Cancel button tap
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFA4A5FF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 23.0, vertical: 12.0),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Color(0xFFA4A5FF), fontSize: 16.0),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Reschedule button tap
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA4A5FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                  child: Text(
                    'Reschedule',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorDetailsCard1() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              isCardTapped = false;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image and Name
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/images/doctorconsultation2.jpg'), // Replace with your image asset path
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dr. Lebron James',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Physician',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('82', 'Patients', Icons.people),
                  _buildStatCard('8', 'Years\nExperience', Icons.timer),
                  _buildStatCard('4.75', 'Ratings', Icons.bar_chart),
                ],
              ),
              const SizedBox(height: 20),
              // About Doctor
              const Text(
                'About Doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Dr. Lebron James is a distinguished physician with over 8 years of experience, highly regarded for his expertise and patient-centered approach. Throughout his career, he has consistently demonstrated a commitment to providing top-quality medical care. Dr. James is known for his ability to connect with patients, understanding their unique needs and offering tailored treatment plans. His dedication to continuous learning ensures he stays updated with the latest advancements in medicine, enabling him to deliver the most effective care possible. Patients trust Dr. James for his professionalism, compassion, and unwavering commitment to their health.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              // Working Time
              const Text(
                'Working Time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Mon - Sat 11:00 AM - 5:00 PM',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              // Communication
              const Text(
                'Communication',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Handle Messaging button tap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatPage()),
                      );
                    },
                    child: _buildCommunicationCard('Messaging', Icons.message),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle Voice Call button tap
                      // _joinVoiceCall();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const CallScreen()),
                      // );
                    },
                    child: _buildCommunicationCard('Voice Call', Icons.phone),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle Video Call button tap
                      // _joinVideoCall();
                    },
                    child:
                    _buildCommunicationCard('Video Call', Icons.video_call),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Book now button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDateTime(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA4A5FF),
                      elevation: 0, // No elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Optional: rounded corners
                      ),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorDetailsCard2() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Details'),
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              isCardTapped = false;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image and Name
              const Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/images/doctorconsultation3.jpg'), // Replace with your image asset path
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Dr. Jane Smith',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Specialist medicine',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatCard('60', 'Patients', Icons.people),
                  _buildStatCard('6', 'Years\nExperience', Icons.timer),
                  _buildStatCard('4.35', 'Ratings', Icons.bar_chart),
                ],
              ),
              const SizedBox(height: 20),
              // About Doctor
              const Text(
                'About Doctor',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Dr. Jane Smith is a dedicated cardiologist with over 15 years of experience. Specializing in heart conditions like coronary artery disease and arrhythmia, he combines expert care with a compassionate approach to help his patients achieve better heart health.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              // Working Time
              const Text(
                'Working Time',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Mon - Sat 11:00 AM - 5:00 PM',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              // Communication
              const Text(
                'Communication',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCommunicationCard('Messaging', Icons.message),
                  _buildCommunicationCard('Voice Call', Icons.phone),
                  _buildCommunicationCard('Video Call', Icons.video_call),
                ],
              ),
              const SizedBox(height: 20),
              // Book now button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDateTime(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA4A5FF),
                      elevation: 0, // No elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // Optional: rounded corners
                      ),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: const Color(0xFFA4A5FF),
          ),
          const SizedBox(height: 10),
          Text(
            number,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunicationCard(String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 30,
            color: const Color(0xFFA4A5FF),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
