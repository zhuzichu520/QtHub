import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "../component"
import "../storage"


Dialog {
    id: dialog
    anchors.centerIn: parent
    modal: Qt.WindowModal
    closePolicy: Popup.NoAutoClose
    width: 260
    height: 160

    signal clickLeft
    signal clickRight

    background: Item {
        Rectangle{
            id:background_layout
            anchors.fill: parent
            color: Theme.colorBackground
        }

        DropShadow{
            anchors.fill: background_layout
            radius: 8.0
            samples: 17
            color: AppStorage.isDark ? "#80FFFFFF" : "#80000000"
            source: background_layout
        }

    }

    Text{
        text: "退出登录后将无法收到新消息，确定退出登录？"
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
