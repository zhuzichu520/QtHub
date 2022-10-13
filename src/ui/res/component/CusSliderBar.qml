import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import "../view"
import "../storage"

Rectangle {
    id:root

    property alias model: listView.model
    property alias avatar: cusAvatar.avatar
    property alias avatarName: cusAvatar.avatarName
    signal clickAvatar
    signal clickMenu

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
        anchors{
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 38
        }
        onClickAvatar: {
            root.clickAvatar()
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
            width: 56
            height: 40
            Text{
                anchors.centerIn: parent
                text:model.icon
                font.family: awesome.name
                color: listView.currentIndex === index ? Theme.colorPrimary : "#999999"
                font.pixelSize: model.fontSize
            }
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    listView.currentIndex = index
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
            horizontalCenter: parent.horizontalCenter
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
