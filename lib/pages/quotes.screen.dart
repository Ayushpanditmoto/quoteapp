import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quoteapp/providers/auth.provider.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Quotes extends StatelessWidget {
  const Quotes({super.key});

  void copy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Copied to Clipboard"),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void sharing(String text) {
    Share.share(text);
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/originals/4b/b5/3c/4bb53c71cabfbcbb780af39792fc67ed.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () {
                auth.logout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 70,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Center(
                child: Text("Motivational Quotes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 6,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
                child: Center(
                  child: Text(
                      "The bulb was not invented by Thomas Edison, it was perfected by him - Thomas Edison",
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 10,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Center(
                child: Text("Thomad Edison",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: BottomNavigationBar(
              currentIndex: 0,
              selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: Colors.transparent,
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.refresh), label: ""),
                BottomNavigationBarItem(
                  icon: InkWell(
                    onTap: () {
                      copy(context,
                          "The bulb was not invented by Thomas Edison, it was perfected by him - Thomas Edison");
                    },
                    child: const Icon(Icons.copy),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: InkWell(
                    child: const Icon(Icons.share),
                    onTap: () {
                      sharing(
                          "The bulb was not invented by Thomas Edison, it was perfected by him - Thomas Edison");
                    },
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
