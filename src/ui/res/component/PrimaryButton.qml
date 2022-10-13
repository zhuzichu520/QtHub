import QtQuick 2.0
import QtQuick.Layouts 1.15
import "../view"
import "../storage"

Rectangle {

    id:layoutButton
    property alias text: buttonText.text
    property color backColor : Theme.colorPrimary
    property color backHoverColor: Qt.lighter(backColor,1.1)
    signal clicked

    width: Math.max(buttonText.width + 20,80)
    height: buttonText.height + 16
    radius: 3
    color:buttonMouse.containsMouse ? backHoverColor : backColor

    MouseArea{
        id:buttonMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            layoutButton.clicked()
        }
    }

    Text {
        id:buttonText
        text: qsTr("按钮")
        anchors.centerIn: parent
        color:"#FFFFFF"
        font.pixelSize: 14
    }

}
