import 'dart:convert';
import 'package:flutter/material.dart';

import '../Models/token_model.dart';
import '../Modules/universal_module.dart';
import '../../global_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../Models/pair_model.dart';
import '../Models/user_model.dart';
import 'auth.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
final databaseReference = database.ref();
// void initiateDatabase(){
//   database.setPersistenceEnabled(true);
//   database.setPersistenceCacheSizeBytes(100000000);
// }
DatabaseReference addPairInRegister(PairModel pair) {
  var id = databaseReference.child('${GlobalClass.user!.uid}/patients/').push();
  pair.masterFilter = generateMasterFilter(pair);
  pair.uid = id.key;
  id.set(pair.toJson());
  return id;
}

void deleteDatabaseNode(DatabaseReference id) {
  databaseReference.child(id.path).remove();
}

DatabaseReference getDatabaseReference(String directory) {
  return databaseReference.child('${GlobalClass.user!.uid}/$directory');
}

Future<DatabaseReference?> addUserDetail() async {
  DatabaseReference? id;
  await getUserDetails().then((value) => {
        if (value == null)
          {
            id = databaseReference
                .child('${GlobalClass.user!.uid}/hospitalDetails/')
                .push(),
            GlobalClass.userDetail = UserModel(
                displayName: GlobalClass.user!.displayName,
                email: GlobalClass.user!.email,
                canAccess: 1,
                phoneNumber: GlobalClass.user!.phoneNumber,
                isAppRegistered: 0),
            id!.set(GlobalClass.userDetail!.toJson()),
          }
        else
          {
            if (value.isOwner == 1)
              id = value.id
            else if (value.isAppRegistered == 1 && value.canAccess == 0)
              id = null
            else
              id = value.id
          }
      });
  return id;
}

void updateClient(PairModel client, DatabaseReference id) {
  client.masterFilter = generateMasterFilter(client);
  id.update(client.toJson());
}

///gets the list of clients in a register.
Future<List<PairModel>> getAllClients() async {
  DatabaseEvent databaseEvent = await databaseReference
      .child('${GlobalClass.user!.uid}/patients/')
      .once();
  DataSnapshot dataSnapshot = databaseEvent.snapshot;
  List<PairModel> clients = [];
  if (dataSnapshot.value != null) {
    Map<String, dynamic> snapshotVal =
        jsonDecode(jsonEncode(dataSnapshot.value));
    snapshotVal.forEach((key, value) {
      PairModel client = PairModel.fromJson(jsonDecode(jsonEncode(value)));
      client.setId(
          databaseReference.child('${GlobalClass.user!.uid}/patients/' + key));
      clients.add(client);
    });
  }
  clients = sortClientsModule("A-Z", clients);
  return clients;
}

Future<List<PairModel>> getNotificationClients(BuildContext context) async {
  await Authentication.initializeFirebase();
  GlobalClass.user ??= FirebaseAuth.instance.currentUser;
  List<PairModel> clients = [];
  if (GlobalClass.user != null) {
    await addUserDetail().then((value) async => {
          if (value != null)
            {
              await getAllClients().then((clientInstances) => {
                    clientInstances.forEach((clientElement) async {
                      clients.add(clientElement);
                    })
                  })
            }
        });
  }
  return clients;
}

///gets list of register indexes enlisted in the account.
// Future<List<RegisterIndexModel>> getAllRegisterIndex() async {
//   DataSnapshot dataSnapshot = await databaseReference
//       .child('${GlobalClass.user.uid}/registerIndex/')
//       .once();
//   List<RegisterIndexModel> registers = [];
//   if (dataSnapshot.value != null) {
//     dataSnapshot.value.forEach((key, value) {
//       RegisterIndexModel register =
//           RegisterIndexModel.fromJson(jsonDecode(jsonEncode(value)), key);
//       register.setId(databaseReference
//           .child('${GlobalClass.user.uid}/registerIndex/' + key));
//       registers.add(register);
//     });
//   }
//   registers.sort((a, b) => a.name.compareTo(b.name));
//   return registers;
// }

///gets the details of the user.
Future<UserModel?> getUserDetails() async {
  DatabaseReference userDetailReference =
      databaseReference.child('${GlobalClass.user!.uid}/hospitalDetails/');
  // userDetailReference.keepSynced(true);
  DatabaseEvent databaseEvent = await userDetailReference.once();
  DataSnapshot dataSnapshot = databaseEvent.snapshot;
  UserModel? userDetail;
  if (dataSnapshot.value != null) {
    Map<String, dynamic> snapshotVal =
        jsonDecode(jsonEncode(dataSnapshot.value));
    snapshotVal.forEach((key, value) {
      userDetail = UserModel.fromJson(jsonDecode(jsonEncode(value)), key);
      userDetail!.setId(databaseReference
          .child('${GlobalClass.user!.uid}/hospitalDetails/' + key));
    });
    // userDetail = UserModel.fromJson(json[json.keys.toList()[0]]);
    // userDetail.setId(databaseReference.child('${GlobalClass.user.uid}/hospitalDetails/'));
  }
  GlobalClass.userDetail = userDetail;
  return userDetail;
}

addToken(UserModel userModel, TokenModel tokenModel) {
  var id = databaseReference.child(userModel.id!.path + "/Tokens/").push();
  id.set(tokenModel.toJson());
  tokenModel.setId(id);
  if (userModel.tokens == null) {
    userModel.tokens = [tokenModel];
  } else {
    userModel.tokens!.add(tokenModel);
  }
}

updateToken(TokenModel tokenModel) {
  tokenModel.id!.update(tokenModel.toJson());
}

///updates the details of the user.
void updateUserDetails(UserModel user, DatabaseReference id) {
  id.update(user.toJson());
}
