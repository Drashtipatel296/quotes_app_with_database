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
    Category(name: 'Happiness', text: '😀'),
    Category(name: 'Leadership', text: '🪯'),
    Category(name: 'Inspiration', text: '⚕️'),
    Category(name: 'Funny', text: '😂'),
    Category(name: 'Life', text: '☺️'),
    Category(name: 'Dream', text: '😴'),
    Category(name: 'Falling in love', text: '❤️'),
    Category(name: 'Friendship', text: '🤝'),
    Category(name: 'Motivational', text: '🎗️'),
    Category(name: 'Breakup', text: '💔'),
    Category(name: 'Alone', text: '😔'),
    Category(name: 'Goals', text: '🎯'),
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
    Get.to(() => HomeScreen(selectedCategories: selectedCategoryNames,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                color: const Color(0xff3B4AB1),
                fontSize: 38,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Get a random mix from selected categories',
              style: GoogleFonts.poppins(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                fontWeight: FontWeight.bold, fontSize: 17),
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
                              Text(category.text, style: TextStyle(fontSize: 22)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
