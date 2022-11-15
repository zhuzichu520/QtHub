import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import Controller
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
                controller.search(q)
                layout_list.visible = true
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
                        controller.search(modelData)
                        layout_list.visible = true
                    }
                }
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
        color:Theme.colorBackground

        Behavior on width{
            NumberAnimation{
                duration: 300
            }
        }

        ListView{
            id:listview_serach
            anchors.fill: parent
            model: controller.searchListModel
            clip: true
            boundsBehavior: ListView.StopAtBounds
            delegate: Item{
                height: 100
                width:listview_serach.width
                Rectangle{
                    height: 1
                    anchors{
                        left: parent.left
                        right: parent.right
                        leftMargin: 60
                        rightMargin: 60
                    }
                    visible: index !== 0
                    color: Theme.colorDivider
                }
                ColumnLayout {
                    anchors{
                        left: parent.left
                        right: parent.right
                        leftMargin: 60
                        rightMargin: 60
                    }
                    Text{
                        text: qsTr(model.fullName)
                        color:"#0969dc"
                        Layout.topMargin: 20
                        font.pixelSize: 15
                    }
                    Text{
                        text: qsTr(model.description)
                        color:Theme.colorFontSecondary
                        visible: text !== ""
                    }
                    RowLayout{
                        visible: model.language !== ""
                        Rectangle{
                            width: 12
                            height: 12
                            radius: 6
                            color:uiHelper.getLanguageColor(model.language)
                        }
                        Text{
                            text: qsTr(model.language)
                            color:Theme.colorFontSecondary
                        }
                    }

                }
            }
        }

        Rectangle{
            anchors.fill: listview_serach
            visible: controller.showLoading
            color:Theme.colorBackground
            CusLoading{
                anchors.centerIn: parent
            }
        }



    }

    CusButton{
        text:"返回"
        height: 30
        anchors{
            top: parent.top
            topMargin: -20
            leftMargin: 10
            left: parent.left
        }
        visible: layout_list.visible
        onClicked: {
            controller.releaseSearch()
            layout_list.visible = false
        }
    }


}
