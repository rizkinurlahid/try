import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';

class JitsiPage extends StatefulWidget {
  @override
  _JitsiPageState createState() => _JitsiPageState();
}

class _JitsiPageState extends State<JitsiPage> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jitsi Page'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 24.0,
              ),
              TextField(
                controller: serverText,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Server URL",
                    hintText: "Hint: Leave empty for meet.jitsi.si"),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: roomText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Room",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: subjectText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Subject",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: nameText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Display Name",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: emailText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                title: Text("Audio Only"),
                value: isAudioOnly,
                onChanged: _onAudioOnlyChanged,
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                title: Text("Audio Muted"),
                value: isAudioMuted,
                onChanged: _onAudioMutedChanged,
              ),
              SizedBox(
                height: 16.0,
              ),
              CheckboxListTile(
                title: Text("Video Muted"),
                value: isVideoMuted,
                onChanged: _onVideoMutedChanged,
              ),
              Divider(
                height: 48.0,
                thickness: 2.0,
              ),
              SizedBox(
                height: 64.0,
                width: double.maxFinite,
                child: RaisedButton(
                  onPressed: () {
                    _joinMeeting();
                  },
                  child: Text(
                    "Join Meeting",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(options,
          listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
            debugPrint("${options.room} will join with message: $message");
          }, onConferenceJoined: ({message}) {
            debugPrint("${options.room} joined with message: $message");
          }, onConferenceTerminated: ({message}) {
            debugPrint("${options.room} terminated with message: $message");
          }));
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}