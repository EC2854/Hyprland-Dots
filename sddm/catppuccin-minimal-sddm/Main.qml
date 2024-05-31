import QtQuick 2.15
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import SddmComponents 2.0

Rectangle {
    id: root
    width: 640
    height: 480

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        cursorShape: Qt.BlankCursor
    }

    Keys.onPressed: {
      if (event.key === Qt.Key_F2 && event.modifiers === Qt.AltModifier) {
        // Alt + F2
        if (!username.visible) {
          username.visible = true;
        }
        usersCycleSelectNext();
      } else if (event.key === Qt.Key_F3 && event.modifiers === Qt.AltModifier) {
        // Alt + F3
        if (!sessionName.visible) {
          sessionName.visible = true;
        }
        sessionsCycleSelectNext();
      } else if (event.key === Qt.Key_F10) {
        // F10
        if (sddm.canSuspend) {
          sddm.suspend();
        }
      } else if (event.key === Qt.Key_F11) {
        // F11
        if (sddm.canPowerOff) {
          sddm.powerOff();
        }
      } else if (event.key === Qt.Key_F12) {
        // F12
        if (sddm.canReboot) {
          sddm.reboot();
        }
      } else if (event.key === Qt.Key_F1) {
        // F1
        helpMessage.visible = !helpMessage.visible;
        mouseArea.cursorShape = Qt.ArrowCursor;
      } else if (event.key === Qt.Key_Escape) {
        // Esc key pressed
        username.visible = false;
        sessionName.visible = false;
        helpMessage.visible = false;
        // Show mouse cursor
        mouseArea.cursorShape = Qt.BlankCursor;
    }
    }

    readonly property color textColor: config.textColor 
    property int currentUsersIndex: userModel.lastIndex
    property int currentSessionsIndex: sessionModel.lastIndex
    property int usernameRole: Qt.UserRole + 1
    property int realNameRole: Qt.UserRole + 2
    property int sessionNameRole: Qt.UserRole + 4
    property string currentUsername: userModel.data(userModel.index(currentUsersIndex, 0), realNameRole) ||
                                     userModel.data(userModel.index(currentUsersIndex, 0), usernameRole)
    property string currentSession: sessionModel.data(sessionModel.index(currentSessionsIndex, 0), sessionNameRole)

    function usersCycleSelectPrev() {
        if (currentUsersIndex - 1 < 0) {
            currentUsersIndex = userModel.count - 1;
        } else {
            currentUsersIndex--;
        }
    }

    function usersCycleSelectNext() {
        if (currentUsersIndex >= userModel.count - 1) {
            currentUsersIndex = 0;
        } else {
            currentUsersIndex++;
        }
    }

    function bgFillMode() {
        switch(config.backgroundMode)
        {
            case "aspect":
                return Image.PreserveAspectCrop;

            case "fill":
                return Image.Stretch;

            case "tile":
                return Image.Tile;

            default:
                return Image.Pad;
        }
    }

    function sessionsCycleSelectPrev() {
        if (currentSessionsIndex - 1 < 0) {
            currentSessionsIndex = sessionModel.rowCount() - 1;
        } else {
            currentSessionsIndex--;
        }
    }

    function sessionsCycleSelectNext() {
        if (currentSessionsIndex >= sessionModel.rowCount() - 1) {
            currentSessionsIndex = 0;
        } else {
            currentSessionsIndex++;
        }
    }


    Connections {
        target: sddm
        function onLoginFailed() {
            backgroundBorder.border.width = 5;
            animateBorder.restart();
            passwordInput.clear();
        }
        function onLoginSucceeded() {
            background.border.width = 0;
            animateBorder.stop();
            mouseArea.cursorShape = Qt.BlankCursor;
        }
    }

    Item {
        id: mainFrame
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x
        y: geometry.y
        width: geometry.width
        height: geometry.height
        Rectangle {
            id: background
            visible: true
            anchors.fill: parent
            color: config.backgroundFill || "transparent"

            Image {
                id: image
                anchors.fill: parent
                source: config.background
                fillMode: bgFillMode()
                z: 2
            }

            Rectangle {
                id: backgroundBorder
                anchors.fill: parent
                z: 3
                border.color: "#ff3117"
                border.width: 0
                color: "transparent"
                Behavior on border.width {
                    SequentialAnimation {
                        id: animateBorder
                        running: false
                        loops: Animation.Infinite
                        NumberAnimation { from: 5; to: 10; duration: 700 }
                        NumberAnimation { from: 10; to: 5;  duration: 400 }
                    }
                }
            }
        }

        TextInput {

            Rectangle {
                id: textInputBackground
                z: -1
                anchors.fill: parent
                radius: 20
                border.color: config.textInputBackground
                color: config.textInputBackground
            }

            id: passwordInput
            width: parent.width/3.5
            height: 50
            font.family: config.font
            font.pointSize: config.passwordCharacterSize
            font.bold: true
            font.letterSpacing: 10

            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            echoMode: TextInput.Password
            color: textColor
            selectionColor: textColor
            selectedTextColor: config.textColor
            clip: true
            horizontalAlignment: TextInput.AlignHCenter
            verticalAlignment: TextInput.AlignVCenter
            passwordCharacter: config.passwordCharacter || "*"

            onAccepted: {
                if (text != "") {
                    sddm.login(userModel.lastUser || "123test", text, currentSessionsIndex);
                }
            }

            cursorDelegate: Rectangle {
                id: passwordInputCursor
                width: 1
                onHeightChanged: height = passwordInput.height/1.5
                anchors.verticalCenter: parent.verticalCenter
                color: (() => {
                        if (config.cursorColor.length == 7 && config.cursorColor[0] == "#") {
                            return config.cursorColor;
                        } else if (config.cursorColor == "constantRandom") {
                            return generateRandomColor();
                        } else {
                            return textColor
                        }
                    })()

                function generateRandomColor() {
                    var color = "#";
                    for (var i = 0; i<3; i++) {
                        var color_number = parseInt(Math.random()*255);
                        var hex_color = color_number.toString(16);
                        if (color_number < 16) {
                            hex_color = "0" + hex_color;
                        }
                        color += hex_color;
                    }
                    return color;
                }
                Connections {
                    target: passwordInput
                    function onTextEdited() {
                        if (config.cursorColor == "random") {
                            passwordInputCursor.color = generateRandomColor();
                        }
                    }
                }
            }
        }

        UsersChoose {
            id: username
            text: currentUsername
            visible: false
            width: mainFrame.width/3.5
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: passwordInput.top
                bottomMargin: 40
            }
            onPrevClicked: {
                usersCycleSelectPrev();
            }
            onNextClicked: {
                usersCycleSelectNext();
            }
        }

        SessionsChoose {
            id: sessionName
            text: currentSession
            visible: false
            width: mainFrame.width/3.5
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: 30
            }
            onPrevClicked: {
                sessionsCycleSelectPrev();
            }
            onNextClicked: {
                sessionsCycleSelectNext();
            }
        }

        Text {
            id: helpMessage
            visible: false
            text: "Show help - F1\n" +
                  "Cycle select next user - alt+F2\n" +
                  "Cycle select next session - alt+F3\n" +
                  "Suspend - F10 [fn+F10]\n" +
                  "Poweroff - F11 [fn+F11]\n" +
                  "Reboot - F12 [fn+F12]"
            color: config.hiddenTextColor
            font.pointSize: 14
            font.family: config.font
            anchors {
                top: parent.top
                topMargin: 30
                left: parent.left
                leftMargin: 30
            }
        }

        Component.onCompleted: {
            passwordInput.forceActiveFocus();
        }

    }
}

