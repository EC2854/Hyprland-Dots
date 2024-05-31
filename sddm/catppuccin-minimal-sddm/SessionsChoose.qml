import QtQuick 2.15
import QtQuick.Controls 2.0

Item {
    id: root
    property string text: ""
    property string prevText: "<"
    property string nextText: ">"
    property int fontPointSize: 16
    property string fontFamily: config.font
    signal prevClicked()
    signal nextClicked()
    Text {
        id: sessionName
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: root.fontPointSize
        font.family: root.fontFamily
        color: config.hiddenTextColor
        text: root.text
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }
    Text {
        id: prevButton
        text: root.prevText
        color: config.hiddenTextColor
        font.pointSize: root.fontPointSize
        font.family: root.fontFamily
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            rightMargin: 10
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.prevClicked();
            }
        }
    }
    Text {
        id: nextButton
        text: root.nextText
        color: config.hiddenTextColor
        font.pointSize: root.fontPointSize
        font.family: root.fontFamily
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.nextClicked();
            }
        }
    }
}
