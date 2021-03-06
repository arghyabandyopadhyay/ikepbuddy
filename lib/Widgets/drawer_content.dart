import '../Models/drawer_action_model.dart';
import '../global_class.dart';
import '../custom_colors.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({Key? key, this.drawerItems, this.scaffoldMessengerKey})
      : super(key: key);
  final List<DrawerActionModel>? drawerItems;
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "IKEP Buddy",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.start,
            ),
            Text(
              "      Version 2021.2",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              textAlign: TextAlign.end,
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: <Widget>[
            if (GlobalClass.user != null)
              DrawerHeader(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.transparent,
                      child: GlobalClass.user?.photoURL != null
                          ? ClipOval(
                              child: Material(
                                color:
                                    CustomColors.firebaseGrey.withOpacity(0.3),
                                child: Image.network(
                                  GlobalClass.user!.photoURL!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Material(
                                color:
                                    CustomColors.firebaseGrey.withOpacity(0.3),
                                child: const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: CustomColors.firebaseGrey,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Text(
                      GlobalClass.user!.displayName!,
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      GlobalClass.user!.email!,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            if (GlobalClass.user != null && drawerItems != null)
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: drawerItems!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(drawerItems![index].iconData),
                      title: Text(
                        drawerItems![index].title,
                      ),
                      onTap: drawerItems![index].onTap,
                    );
                  }),
            // ListTile(
            //   leading: Icon(Icons.help),
            //   title: Text("Help and Feedback"),
            //   onTap: ()async{
            //   Navigator.pop(context);
            //   Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>HelpAndFeedbackPage()));
            //   },
            // ),
            // if(GlobalClass.user!=null&&GlobalClass.userDetail!=null&&GlobalClass.userDetail.isOwner==1)ListTile(
            //   leading: Icon(Icons.send),
            //   title: Text("Dispatch Notification"),
            //   onTap: ()async{
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>DispatchNotificationConsole()));
            //   },
            // ),
            // if(GlobalClass.user!=null&&GlobalClass.userDetail!=null&&GlobalClass.userDetail.isOwner==1)ListTile(
            //   leading: Icon(Icons.account_box),
            //   title: Text("Users Access"),
            //   onTap: ()async{
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>ClientAccessEditPage()));
            //   },
            // ),
          ]),
    );
  }
}
