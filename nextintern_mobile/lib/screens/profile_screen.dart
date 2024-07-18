import 'package:flutter/material.dart';
import 'package:nextintern_mobile/widgets/custom_app_bar.dart';
import 'package:nextintern_mobile/models/profile_model.dart';
import 'dart:async';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileModel _profile;
  bool _isLoading = true; // Biến kiểm soát loading state

  @override
  void initState() {
    super.initState();
    // Delay 1 giây rồi cập nhật _isLoading và _profile
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        _profile = ProfileModel(
          name: 'Lê Văn Dương',
          age: 22,
          occupation: 'Sinh viên',
          location: 'Hà Nội',
          skills: 'Flutter, Dart, Firebase',
          languages: 'Tiếng Anh, Tiếng Việt',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: const GradientAppBar(
          title: 'Profile',
        ),
      ),
      body: _isLoading // Kiểm tra loading state để hiển thị widget tương ứng
          ? const Center(child: CircularProgressIndicator()) // Hiển thị loading
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildInfoCard('Name', _profile.name ?? 'N/A', Icons.person),
                  _buildInfoCard(
                      'Age', _profile.age?.toString() ?? 'N/A', Icons.cake),
                  _buildInfoCard(
                      'Occupation', _profile.occupation ?? 'N/A', Icons.work),
                  _buildInfoCard('Location', _profile.location ?? 'N/A',
                      Icons.location_on),
                  _buildInfoCard(
                      'Skills', _profile.skills ?? 'N/A', Icons.code),
                  _buildInfoCard(
                      'Languages', _profile.languages ?? 'N/A', Icons.language),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
                'assets/profile_picture.png'), // Thay thế bằng đường dẫn tới ảnh đại diện của bạn
          ),
          const SizedBox(height: 10),
          Text(
            _profile.name ?? 'N/A',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            _profile.occupation ?? 'N/A',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
