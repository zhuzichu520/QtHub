import QtQuick 2.15
import "../global/global.js" as Global
import "../storage"

Item {
    id:root

    property alias icon : textIcon.text
    property alias tipText: tool_tip.text
    property color color : AppStorage.isDark?"#AAFFFFFF" : "#666"
    signal clickEvent
    property alias iconSize: textIcon.font.pixelSize

    property color normalColor : "#00000000"
    property color hoverColor: AppStorage.isDark ? "#33FFFFFF" : Qt.darker(normalColor,1.2)
    property color hoverTextColor :  color
    property string fontFamily: awesome.name

    height: 30
    width: 30

    FontLoader {
        id: awesome
        source: "qrc:/font/iconfont.ttf"
    }

    Rectangle{
        anchors.fill: parent
        color: mouseArea.containsMouse ? hoverColor : normalColor
    }

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: clickEvent()
    }

    CusToolTip{
        id:tool_tip
        visible: {
            if(tool_tip.text === ""){
                return false
            }
            return mouseArea.containsMouse
        }
        delay: 1000
    }

    Text {
        id:textIcon
        font.pixelSize: 20
        font.family: fontFamily
        color: mouseArea.containsMouse ? hoverTextColor : root.color
        anchors.centerIn: parent
    }

}
