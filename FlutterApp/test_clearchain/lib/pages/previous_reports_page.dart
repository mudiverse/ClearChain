// previous_reports_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PreviousReportsPage extends StatefulWidget {
  const PreviousReportsPage({Key? key}) : super(key: key);

  @override
  State<PreviousReportsPage> createState() => _PreviousReportsPageState();
}

class _PreviousReportsPageState extends State<PreviousReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Reports"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reports').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final reports = snapshot.data?.docs ?? [];
          if (reports.isEmpty) {
            return const Center(child: Text("No reports found."));
          }
          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final doc = reports[index];
              final data = doc.data() as Map<String, dynamic>;
              final title = data['name'] ?? "No name";
              final description = data['description'] ?? "No Description";
              String formattedTimestamp = "";
              if (data['timestamp'] != null && data['timestamp'] is Timestamp) {
                final Timestamp ts = data['timestamp'];
                formattedTimestamp =
                    DateFormat('yyyy-MM-dd HH:mm').format(ts.toDate());
              } else if (data['timestamp'] is String) {
                formattedTimestamp = data['timestamp'];
              }
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  title: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(formattedTimestamp),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(description),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
