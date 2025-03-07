// ReportPage.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:test_clearchain/firebase_api.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  DateTime? _selectedDate;
  // File? _image;

  // Function to pick an image from the camera
  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile =
  //   await picker.pickImage(source: ImageSource.camera);
  //   // if (pickedFile != null) {
  //   //   setState(() {
  //   //     // _image = File(pickedFile.path);
  //   //   });
  //   // }
  // }

  // Function to open the date picker and select a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to submit the report
  // Function to submit the report
  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Submission"),
            content: const Text("Are you sure you want to submit this report?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cancel submission
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close dialog

                  try {
                    // Debug: Print before calling the API function
                    print("Submitting report to Firestore...");

                    // Call the API Function
                    await submitReportToFirestore(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      date: _selectedDate ?? DateTime.now(),
                      location: _locationController.text,
                      // image: _image,
                    );

                    // Debug: Print success
                    print("Report submitted successfully.");

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Report Submitted")),
                    );
                  } catch (e) {
                    // Debug: Print error message
                    print("Error submitting report: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to submit report")),
                    );
                  }
                },
                child: const Text("Confirm"),
              ),
            ],
          );
        },
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    // Use your app's theme for consistency.
    return Scaffold(
      appBar: AppBar(
        title: const Text("Submit Report"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name of Person Responsible",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Description of Incident",
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please provide a description";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Date Field with DatePicker
              Row(
                children: [
                  Expanded(
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "Date of Incident",
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _selectedDate == null
                            ? "Select Date"
                            : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Location Field
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter the location";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Image Attachment Section
              // _image != null
              //     ? Image.file(
              //   _image!,
              //   height: 150,
              //   fit: BoxFit.cover,
              // )
              //     : const SizedBox.shrink(),
              // ElevatedButton.icon(
              //   onPressed: _pickImage,
              //   icon: Icon(
              //     Icons.camera_alt,
              //     color: Theme.of(context).colorScheme.inversePrimary,
              //   ),
              //   label: Text(
              //     "Attach Image",
              //     style: TextStyle(
              //       color: Theme.of(context).colorScheme.inversePrimary,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 24),
              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: _submitReport,
                  child: Text(
                    "Submit Report",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
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
}
