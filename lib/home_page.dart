import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MaterialButton(
                minWidth: 40,
                onPressed: (){},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.star,
                      color: Colors.blue,
                    ),
                    Text("tab",style: TextStyle(color: Colors.blue),)
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: (){},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    Text("tab",style: TextStyle(color: Colors.blue),)
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: (){},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    Text("tab",style: TextStyle(color: Colors.blue),)
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: (){},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    Text("tab",style: TextStyle(color: Colors.blue),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
