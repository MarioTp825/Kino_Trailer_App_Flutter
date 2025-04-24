import 'package:flutter/material.dart';
import 'package:my_movie_detail/presenter/ui/style/movie_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MeInfoScreen extends StatelessWidget {
  const MeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.chevron_left),
        ),
        title: const Text("Developer"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/me.JPG',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text("Mario Tepe", style: context.themeFonts.headlineLarge),
          
              const SizedBox(height: 30),
              _buildSocialNetwork(context, {
                "Linked In": "https://www.linkedin.com/in/marioandrestepe",
                "GitHub": "https://www.github.com/MarioTp825",
                "Instagram": "https://www.instagram.com/mariotp85/",
              }),
              const SizedBox(height: 15),
              Text("This app was develop for educational purposes only for:"),
              const SizedBox(height: 5),
              Image.asset(
                'assets/images/flutter_guatemala.png',
                width: double.infinity,
                height: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              _buildSocialNetwork(context, {
                "YouTube": "https://www.youtube.com/@FlutterGuatemala",
                "Linked In": "https://www.linkedin.com/company/flutter-guatemala/about/",
                "Instagram": "https://www.instagram.com/flutter_gt",
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialNetwork(
    BuildContext context,
    Map<String, String> networks,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Social Networks", style: context.themeFonts.titleMedium),
        const SizedBox(height: 15),
        ...networks.entries.map((entry) {
          return Column(
            children: [
              _buildItem(
                context,
                "${entry.key}:",
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(entry.value);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Could not launch ${entry.value}"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    entry.value.split(".").sublist(1).join(".") ,
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildItem(BuildContext context, String label, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: context.themeFonts.titleSmall),
        const SizedBox(width: 8),
        Expanded(child: value),
      ],
    );
  }
}
