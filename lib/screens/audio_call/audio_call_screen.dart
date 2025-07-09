import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yg_assignment/constants/constants.dart';
import 'package:yg_assignment/data/models/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallScreen extends StatefulWidget {
  final UserModel userData;
  const AudioCallScreen({super.key, required this.userData});

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ZegoUIKitPrebuiltCall(
              appID: AppConstants.zegoAppId,
              appSign: AppConstants.zegoAppSign,
              userID:
                  FirebaseAuth.instance.currentUser?.uid ??
                  AppConstants.dummyUserId,
              userName: widget.userData.name,
              callID:
                  widget.userData.audioCallToken.isNotEmpty
                      ? widget.userData.audioCallToken
                      : 'default_room',
              config:
                  ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
                    ..topMenuBar.isVisible = true
                    ..bottomMenuBar.isVisible = true,
            ),
          ),
        ],
      ),
    );
  }
}
