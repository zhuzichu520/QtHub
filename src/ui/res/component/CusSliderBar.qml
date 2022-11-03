import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "../view"
import "../storage"

Rectangle {
    id:root

    property alias model: listView.model
    property alias avatar: cusAvatar.source
    signal clickAvatar
    signal clickMenu
    clip: true
    width: 56
    height: parent.height
    anchors.left: parent.left
    color: "#FF2E2E2E"

    FontLoader {
        id: awesome
        source: "qrc:/font/iconfont.ttf"
    }


    CusAvatar{
        id:cusAvatar
        width: 38
        height: 38
        anchors{
            left: parent.left
            leftMargin: 28
            top: parent.top
            topMargin: 38
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {

                clickAvatar()
            }
        }

    }


    ListView{
        id:listView
        boundsBehavior: Flickable.StopAtBounds
        anchors{
            top:cusAvatar.bottom
            topMargin: 14
            left: parent.left
            right:parent.right
            bottom: parent.bottom
        }
        delegate: Item{
            width: root.width
            height: 40

            Rectangle{
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    leftMargin: 14
                    rightMargin: 14
                }
                visible: mouse_item.containsMouse
                color:"#66000000"
                radius: 6
            }

            MouseArea{
                id:mouse_item
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    listView.currentIndex = index
                }
            }

            Text{
                id:ic_title
                text:model.icon
                font.family: awesome.name
                color: listView.currentIndex === index ? Theme.colorPrimary : "#DDDDDD"
                font.pixelSize: model.iconSize
                anchors{
                    left: parent.left
                    leftMargin: 28
                    verticalCenter: parent.verticalCenter
                }
            }

            Text{
                text:model.name
                color: ic_title.color
                font.pixelSize: model.fontSize
                anchors{
                    left: ic_title.right
                    leftMargin: 10
                    verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    Text{
        font.family: awesome.name
        font.pixelSize: 26
        text:"\ueaf1"
        color: item_mouse.containsMouse? "#FFFFFF" : "#999999"
        anchors{
            right: parent.right
            rightMargin: 14
            bottom: parent.bottom
            bottomMargin: 20
        }
        MouseArea{
            id:item_mouse
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                clickMenu()
            }
        }
    }

    function getIndex(){
        return listView.currentIndex
    }

    function setIndex(index){
        listView.currentIndex = index
    }

    function getUrl(){
        return sliderModel.get(curIndex).url
    }

}
