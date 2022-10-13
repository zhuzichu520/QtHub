import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id:root
    width: 30
    height: 30

    property alias tipText: tool_tip.text
    property alias source: iamge_icon.source
    property int srcWidth: 30
    property int srcHeight: 30
    radius: 3
    signal clicked

    color: mouse_btn.containsMouse ?  "#11000000" :  "#00000000"
    MouseArea{
        id:mouse_btn
        hoverEnabled: true
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.clicked()
        }
    }
    CusToolTip {
        id:tool_tip
        visible: mouse_btn.containsMouse
    }
    Image {
        id:iamge_icon
        source: "qrc:/image/ic_main_bottom_approval.png"
        width: srcWidth
        height: srcHeight
        anchors.centerIn: parent
    }
}
