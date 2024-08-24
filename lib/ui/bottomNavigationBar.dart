import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:photo_storage_application/ui/galaryFolder/galaryScreen.dart';
import 'package:photo_storage_application/ui/homeFolder/HomeScreen.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    GalaryScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  String userId = '';
  Map<String, dynamic>? userData;

  void _initializeUser() async {
    print("user initialization starts ");
    userId = (await getCurrentUserId()) ?? "";

    if (userId.isNotEmpty) {
      userData = await getUserDetails(userId);
      setState(() {
        print("userData ${userData.toString()}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: userData != null
          ? CustomDrawer(
              userName: userData?['name'] ?? 'User Name',
              userEmail: userData?['email'] ?? 'user@example.com',
              userImage: userData?['image'] ??
                  '', // Provide a default image URL or path
            )
          : const CustomDrawer(
              userName: 'User Name',
              userEmail: 'user@example.com',
              userImage: '', // Provide a default image URL or path
            ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_album),
            label: 'Galary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Method to build AppBar
AppBar _buildAppBar() {
  return AppBar(
    title: const Text(
      'Flutter Gallery Application',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blue,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.white),
  );
}

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userImage;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: const NetworkImage(
                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKYAAACUCAMAAAAu5KLjAAAAMFBMVEXk5ueutLeorrHn6eqrsbTh4+Tb3t+yuLvFycu2u76+w8W6v8Lq7O3Y29zKztDQ09X+iHusAAADy0lEQVR4nO2b25arIAxAkYjc5f//9oB2Ou1MHbloomexH/rQp72CCbfAWKfT6XQ6nU6n0+l0Op3/EnCOiSkhwAG1zQbAgtJyWJBSK88uZwpsmjXn4/DNyEcbJriQKjhv5Kvil+kozXQdT6/HD5IPUyMuIQpC8S3JVXS+gKgLn4b7XVR7R62p9iQX0ZlWUpgcy+hpKC1hd8Cfnoru+xQyU5I0nsLmxnL1pImnK7JMeUThCYoXWUbPgO8JvlAyIdA1WUH6PMOpscu8yyyYPzyRP0+YaizjOnRC1WRVwcSeNavyZ/VEzaLKYKZJEzGLRGnJfAHPErJWbxvhxKvxUFEzn5p4S5BQH0zEmtQy5mnUkTTLFnC/NLEWyFPDpxmROJrgW4I5DBzFsjGDoqbH0ayeglaQlknQlEERgzJfthT3BYszrbdqapxUbxxzrIrUNY+k0RJJsznTcVLoJgUJbKMmTnnPOyDeButM4SZLj5ss5O6xLL7LJqNty8axtmxtuwy8Q7mbHCe4exzOMFGvKdEkWdPBIeKx9l2OYeEWh9pxJqrT1Mg3Q3UlnuCeTVdYIu3QX6nIIklwGQhz8T0BwdVq+X0gzUV18bU/XRtFgSdhUwrknyFyRWbJUoNPXh5xwsaZBMw5Ay5JcvwV5/Vu85m9QNvhbisfn6/Rb+qEGTYbI6W5hmQCvJIfWjjHUaoLjPc3wETQ4/vg89H6C3Ru/gAc+NlaLRPamnkC8q7NDSBGdfLeT4JdtqE8WYL7Aq7Uo80WtyWEs1JxxGPaJAYprVFzSHFl9MLRIPoZLR92b2m+/KONmVP7O51qVFyeDWx2kz904480gaR8gvDBjn9OP+9wLudYnzBdwU3K7gTxY1y1ClhVKsYjVOwqH6bDgDIvQZwXh4aeruX5Qzh5cgLn7eYqoyCkOpz4kQLbX1tmm562ugNvCjJ7V1SeUqIAtheVlaLHvygBFg6WTPCD3xLBZJuye4tj93IZb4KqsUd5gjgnlCvjcEy5h8Oq0BZHHIG56tuAbA44BIPGy/M8T9tYQlvu0/A8YUaxTJ4NFbTtRrrMs/4qxmHFcvGsLaAo2fPiWfnW7fxK9MOzri6dXdV/e/pyz7rnVY0UpxHyh7lSftvR2GtU61naVUMx5IkiSZhOXLr9RdnjrNJ3swdSsPokyZ+Voiyi+jIT+U1f2PPPKwVNK3gLo09kf5yUkgPPnTI9UTVaye1bcYbSMrtxpbmvvZW8UZ+ILfNaVyBQa2ZVeLTd5CY26+OkrZpDZvdxW7v4IWRpSk4N0muITqdzMf4B56czAiwYanUAAAAASUVORK5CYII=',
                  ),
                  child: Container(
                    color: Colors.transparent,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/androfit_logo.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16), // Space between the image and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _createDrawerItem(
            icon: Icons.photo_album,
            text: 'Gallery',
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  ListTile _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}

Future<Map<String, dynamic>?> getUserDetails(String userId) async {
  try {
    // Reference to the USERS collection
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('USERS').doc(userId).get();

    // Check if the document exists
    if (userDoc.exists) {
      // Access and return the data

      return userDoc.data() as Map<String, dynamic>?;
    } else {
      print("User does not exist");
      return null;
    }
  } catch (e) {
    print("user Error getting user details: $e");
    return null;
  }
}

Future<String?> getCurrentUserId() async {
  // Get the currently signed-in user
  User? currentUser = FirebaseAuth.instance.currentUser;

  // Check if a user is signed in
  if (currentUser != null) {
    String userId = currentUser.uid;
    print("Current User ID: $userId");
    return userId.toString();
    // You can use the userId as needed in your application
  } else {
    print("No user is currently signed in.");
    return "";
  }
}
