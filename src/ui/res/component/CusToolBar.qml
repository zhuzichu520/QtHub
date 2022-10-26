import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import "../storage"
import "../view"


Rectangle {

    property string title
    property url logo
    property var window: Window.window
    property bool maxEnable: true
    property bool minEnable: true
    property bool closeEnable: true
    property bool darkEnable: false
    property bool topEnable: false
    property bool isTop : false
    color: Theme.colorBackground
    property var onCloseEvent
    property var onMinEvent

    property alias minColor:btnMin.color
    property alias minHoverColor: btnMin.hoverColor

    property alias maxColor:btnMax.color

    property alias closeColor:btnClose.color

    property bool moving: false

    clip: true
    height: 30

    onIsTopChanged: {
        if(isTop){
            window.flags = window.flags | Qt.WindowStaysOnTopHint
        }else{
            window.flags = window.flags &~ Qt.WindowStaysOnTopHint
        }
    }

    MouseArea{

        property point clickPos: "0,0"

        id:mouse_bar
        anchors.fill: parent
        visible: appConfig.isLinux()
        onPressed: {
            clickPos = Qt.point(mouse.x,mouse.y)
            moving = true
            mouse.accepted = true
        }
        onReleased: {
            moving = false
            mouse.accepted = true
        }
        onPositionChanged: {
            var delta = Qt.point(mouse.x - clickPos.x,mouse.y - clickPos.y)
            window.x = window.x + delta.x
            window.y = window.y + delta.y
            mouse.accepted = true
        }
        Component.onCompleted: Window.window.setHitTestVisible(mouse_bar, true)
    }

    anchors{
        left: parent.left
        right: parent.right
        top:parent.top
    }

    function toggleMaximized() {
        if (window.visibility === Window.Maximized) {
            window.showNormal();
        } else {
            window.showMaximized();
        }
    }

    Item {
        id:layout_top
        anchors.fill: parent

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
        }

        RowLayout {
            spacing: 5
            anchors.left: parent.left
            anchors.leftMargin: 8
            height: parent.height
            Image {
                sourceSize: Qt.size(15,15)
                source: logo
            }

            Text {
                text: title
                font.pixelSize: 12
                color:Theme.colorFontPrimary
            }
        }

        RowLayout {
            spacing: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            height: parent.height

            CusToolButton {
                id:btnDark
                icon: AppStorage.isDark ? "\ue6c9" : "\ue6e6"
                color: AppStorage.isDark ? "#FA9D16" : "#FA9D16"
                onClickEvent: {
                    AppStorage.isDark = !AppStorage.isDark
                }
                visible: darkEnable
                Component.onCompleted: Window.window.setHitTestVisible(btnDark, true)
            }

            CusToolButton {
                id:btnTop
                icon: "\ue770"
                onClickEvent: { isTop = !isTop }
                iconSize : 16
                visible: topEnable
                color: isTop ? Theme.colorPrimary : "#666"
                Component.onCompleted: Window.window.setHitTestVisible(btnTop, true)
            }

            CusToolButton {
                id:btnMin
                icon: "\ue65a"
                visible: minEnable
                iconSize : 15
                onClickEvent: {
                    if(onMinEvent)
                        onMinEvent()
                    else
                        window.showMinimized()
                }
                tipText:"最小化"
                Component.onCompleted: Window.window.setHitTestVisible(btnMin, true)
            }
            CusToolButton {
                id:btnMax
                icon: window.visibility === Window.Maximized ? "\ue692" : "\ue65d"
                onClickEvent: window.toggleMaximized();
                visible: maxEnable
                iconSize : 15
                tipText:  window.visibility === Window.Maximized ? "还原" : "最大化"
                Component.onCompleted: Window.window.setHitTestVisible(btnMax, true)
            }
            CusToolButton {
                id:btnClose
                icon: "\ue660"
                onClickEvent: {
                    if(onCloseEvent)
                        onCloseEvent()
                    else
                        window.close()
                }
                hoverColor: "#E81123"
                hoverTextColor: "#FFFFFF"
                visible: closeEnable
                iconSize : 15
                tipText:"关闭"
                Component.onCompleted: Window.window.setHitTestVisible(btnClose, true)
            }
        }
    }


}
