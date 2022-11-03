import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import "../storage"
import "../view"


Rectangle {

    id:root
    property string title
    property url logo
    property bool maxEnable: !(window.minimumWidth === window.maximumWidth && window.minimumHeight === window.maximumHeight)
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
                normalColor: root.color
                tipText: AppStorage.isDark ? "白天模式" : "夜间模式"
                visible: darkEnable
            }

            CusToolButton {
                id:btnTop
                icon: "\ue770"
                onClickEvent: { isTop = !isTop }
                iconSize : 16
                normalColor: root.color
                visible: topEnable
                tipText: isTop ? "取消置顶" : "窗口置顶"
                color: isTop ? Theme.colorPrimary :  (AppStorage.isDark?"#AAFFFFFF" : "#666")
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
                normalColor: root.color
                tipText:"最小化"
            }
            CusToolButton {
                id:btnMax
                icon: window.visibility === Window.Maximized ? "\ue692" : "\ue65d"
                onClickEvent: window.toggleMaximized();
                visible: maxEnable
                iconSize : 15
                normalColor: root.color
                tipText:  window.visibility === Window.Maximized ? "还原" : "最大化"
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
            }
        }
    }


}
