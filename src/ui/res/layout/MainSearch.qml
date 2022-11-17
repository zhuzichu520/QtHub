import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls.Material as M
import Controller
import "../js/Router.js" as R
import "../storage"
import "../component"
import "../view"


Item {

    id:root

    onVisibleChanged: {
        edit_search.inputFocus(visible)
    }

    SearchController{
        id:controller
    }

    Item{
        width: 300
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
                navigateRestart(R.WINDOW_SEARCH,{keyword:q})
                controller.addHistory(q)
            }
        }

        Text{
            id:text_history
            text: "历史记录"
            font.bold: true
            anchors{
                top: edit_search.bottom
                topMargin: 20
                left: parent.left
            }
            font.pixelSize: 12
            color:Theme.colorFontPrimary
        }

        Flow{
            id:layout_history
            anchors{
                top:text_history.bottom
                topMargin: 5
                left: parent.left
                right: parent.right
            }
            spacing: 10

            Repeater{
                model:controller.historyList
                delegate: CusButton{
                    text: modelData
                    onClicked: {
                        navigateRestart(R.WINDOW_SEARCH,{keyword:modelData})
                        controller.addHistory(modelData)
                    }
                }
            }
        }
    }
}
