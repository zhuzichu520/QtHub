import QtQuick
import QtQuick.Controls
import QtQuick.Window
import "../storage"
import "../component"


Item {

    id:root

    onVisibleChanged: {
        edit_search.inputFocus(visible)
    }

    Item{
        width: childrenRect.width
        height: childrenRect.height
        anchors{
            top: parent.top
            topMargin: 100
            horizontalCenter: parent.horizontalCenter
        }

        PrimaryTextField{
            id:edit_search
            width: 200
            anchors{
                left:parent.left
                top: parent.top
            }
            lableText:"请输入搜索关键字"
        }

        PrimaryButton{
            text:"搜索"
            width: 60
            height: 30
            anchors{
                left: edit_search.right
                leftMargin: 10
                bottom: edit_search.bottom
            }
            onClicked: {
                var q = edit_search.text
                if(q===""){
                    showErrorToast("请输入搜索关键字！")
                    return
                }
                layout_list.visible = true
            }
        }

    }

    Rectangle{
        id:layout_list
        anchors.fill: parent
        visible: false
        MouseArea{
            anchors.fill: parent
        }

        Behavior on width{
            NumberAnimation{
                duration: 300
            }
        }

        PrimaryButton{
            text:"返回"
            width: 60
            height: 30
            onClicked: {
                layout_list.visible = false
            }
        }

    }


}
