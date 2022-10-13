import QtQuick 2.15
import "../storage"
import "../view"

Rectangle {

    id:layoutButton
    property string text : "Button"
    property color backColor: AppStorage.isDark ? "#333333" : "#EEEEEE"
    property color hoveColor: Qt.darker(backColor,1.2)
    radius: 3
    border{
        width: 1
        color:Theme.colorDivider
    }
    color: mouseButton.containsMouse ? hoveColor : backColor
    width: textButton.width+20
    height: textButton.height+16
    antialiasing: true
    smooth: true
    signal clicked

    Text{
        id:textButton
        text: layoutButton.text
        anchors.centerIn: parent
        color: Theme.colorPrimary
        font.pixelSize: 12
    }

    MouseArea{
        id:mouseButton
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked:layoutButton.clicked()
    }

}
