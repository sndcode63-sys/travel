import 'package:flutter/material.dart';



class VerificationDocScreen extends StatelessWidget {
  const VerificationDocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification Documents",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              "Verification Information",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color(0xFFF0F0F5),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildVerificationField(
              labelText: "Aadhar Number",
              value: "2546525488882451",
            ),
            _buildVerificationField(
              labelText: "PAN Number",
              value: "NWSS7764D",
            ),
            _buildVerificationField(
              labelText: "Passport Number",
              value: "256684579485",
            ),
            _buildVerificationField(
              labelText: "Rera Certificate",
              value: "Rajasthan",
            ),
            _buildVerificationField(
              labelText: "Highest Qualification",
              value: "12th",
            ),
            _buildVerificationField(
              labelText: "Police Verification",
              value: "KC22564KK",
            ),
            _buildVerificationField(
              labelText: "Bank Account",
              value: "22548655587457",
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Handle save button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationField({
    required String labelText,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const Icon(
                Icons.verified,
                color: Colors.deepPurple,
                size: 18,
              ),
              const SizedBox(width: 24),
              const Text(
                'Upload Image',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 20,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}