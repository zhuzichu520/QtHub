import QtQuick
import QtQuick.Controls
import "../storage"

Button {
    id: control

    property int pageNumber: -2
    property int pageCurrent: -3
    property color textColor: "#666666"
    property color highlightedColor: "#1989FA"

    implicitWidth: implicitContentWidth+leftPadding+rightPadding
    implicitHeight: implicitContentHeight+topPadding+bottomPadding
    padding: 0
    text: pageNumber

    contentItem: Text {
        text: control.text
        font: control.font
        color: pageNumber===pageCurrent?"#FFFFFF":textColor
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        radius: 5
        color: pageNumber===pageCurrent ? highlightedColor : "#00000000"


        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            radius: 5
            visible: {
                if(!control.enabled)
                    return false
                return control.hovered
            }
            border{
                width: 1
                color: Theme.colorDivider
            }
        }

        MouseArea{
            id:btn_mouse
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            cursorShape: Qt.PointingHandCursor
        }


    }
}
