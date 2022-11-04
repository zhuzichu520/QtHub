import QtQuick 2.15
import QtQuick.Controls 2.15
import Qt5Compat.GraphicalEffects
import "../component"
import "../storage"


Dialog {
    id: dialog
    anchors.centerIn: parent
    modal: Qt.WindowModal
    closePolicy: Popup.NoAutoClose
    width: 260
    height: 160

    property string message: "消息内容"

    signal clickLeft
    signal clickRight

    background: Item {
        Rectangle{
            id:background_layout
            anchors.fill: parent
            radius: 5
            color: Theme.colorBackground
        }
        Shadow{
            radius: 5
        }
    }

    Text{
        text: message
        font.pixelSize: 14
        wrapMode: Text.WrapAnywhere
        color:Theme.colorFontPrimary
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: 20
            leftMargin: 15
            rightMargin: 15
        }
    }

    PrimaryButton{
        width: 92
        height: 30
        text:"确定"
        anchors{
            left: parent.left
            bottom:parent.bottom
            bottomMargin: 15
            leftMargin: 15
        }
        onClicked: {
            dialog.close()
            clickLeft()
        }
    }

    CusButton{
        id:right
        width: 92
        height: 30
        text:"取消"
        anchors{
            right: parent.right
            bottom:parent.bottom
            rightMargin: 15
            bottomMargin: 15
        }
        onClicked: {
            dialog.close()
            clickRight()
        }
    }

}
