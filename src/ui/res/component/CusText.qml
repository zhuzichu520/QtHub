import QtQuick 2.0

Text {
    id: text_name

    signal clickEvent

    MouseArea {
        id:mouse_text
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            line_name.opacity = 1
        }
        onExited: {
            line_name.opacity = 0
        }
        onClicked: {
            clickEvent()
        }
    }

    Rectangle {
        id: line_name
        height: 1
        width: text_name.width
        opacity: 0
        anchors.bottom: parent.bottom
        Behavior on opacity {
            NumberAnimation {
                duration: 300
            }
        }
    }

}
