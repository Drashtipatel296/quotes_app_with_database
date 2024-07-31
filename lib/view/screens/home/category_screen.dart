import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class Category {
  final String name;
  final String text;

  Category({required this.name, required this.text});
}

class CategorySelectionScreen extends StatefulWidget {
  const CategorySelectionScreen({super.key});

  @override
  _CategorySelectionScreenState createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  final List<Category> categories = [
    Category(name: 'Love', text: '🩷'),
    Category(name: 'Affirmation', text: '🪯'),
    Category(name: 'Motivation', text: '⚕️'),
    Category(name: 'Positivity', text: '😛'),
    Category(name: 'Mental Health', text: '🧑‍⚕️'),
    Category(name: 'Discipline', text: '🕴️'),
    Category(name: 'Broken', text: '💔'),
    Category(name: 'Self Esteem', text: '🙋‍♀️'),
    Category(name: 'Success', text: '🎯'),
    Category(name: 'Friendship', text: '🤝'),
    Category(name: 'Loyalty', text: '🥰'),
    Category(name: 'Kindness', text: '😊'),
    Category(name: 'Funny', text: '😂'),
    Category(name: 'Happiness', text: '😀'),
    Category(name: 'Sad', text: '😔'),
    Category(name: 'Ego', text: '😎'),
  ];

  final Map<String, bool> selectedCategories = {};

  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      selectedCategories[category.name] = false;
    }
  }

  void navigateToHomeScreen() {
    final selectedCategoryNames = selectedCategories.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    Get.to(() => HomeScreen(selectedCategories: selectedCategoryNames));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.close, size: 35, color: Color(0xff3B4AB1)),
            onPressed: () {
              // Close button action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              style: GoogleFonts.poppins(
                color: Color(0xff3B4AB1),
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Get a random mix from selected categories',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 1.8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff3B4AB1),
                        width: 2.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 21),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Checkbox(
                                  shape: CircleBorder(),
                                  activeColor: Color(0xff3B4AB1),
                                  value: selectedCategories[category.name],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategories[category.name] = value!;
                                    });
                                  },
                                ),
                              ),
                              Text(category.text, style: TextStyle(fontSize: 28)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: navigateToHomeScreen,
                child: Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}