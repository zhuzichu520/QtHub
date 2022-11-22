import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "../js/Router.js" as R
import Controller
import "../component"
import "../storage"

CusWindow {
    id:window
    width: 450
    height: 640
    minimumWidth: 450
    minimumHeight: 640
    title: "搜索"

    property string keyword

    SearchController{
        id:controller
    }

    Component.onCompleted: {
        controller.search(keyword,1,20)
    }

    page: CusPage{

        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: true
            title:window.title
        }

        Rectangle{
            id:layout_list
            anchors{
                top: toolBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
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
                ScrollBar.vertical: ScrollBar {}
                footer: Item{
                    width: listview_serach.width
                    height: 50
                    Pagination2{
                        id:pagination
                        height: 40
                        anchors.centerIn: parent
                        anchors{
                            bottom: parent.bottom
                        }
                        pageCurrent: 1
                        textColor:Theme.colorFontSecondary
                        itemCount: Math.min(controller.totalCount,1000)
                        onRequestPage: {
                            controller.search(keyword,page,count)
                        }
                    }
                    function resetPage(){
                        pagination.pageCurrent = 1
                    }
                }
                delegate: ItemLayout{
                    height: layout_item.height
                    width:listview_serach.width
                    color:Theme.colorBackground1
                    onClicked: {
                        navigateRestart(R.WINDOW_REPOSITORIES,{login:model.login,name:model.name})
                    }
                    onRightClicked: {
                        menu_item.showMenu(model)
                    }
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
                        id:layout_item
                        anchors{
                            left: parent.left
                            right: parent.right
                            leftMargin: 60
                            rightMargin: 60
                        }
                        TextSelection{
                            text:qsTr(model.fullName)
                            color:"#0969dc"
                            font.pixelSize: 15
                            width: layout_item.width
                            Layout.topMargin: 20
                        }
                        TextSelection{
                            text:qsTr(model.description)
                            color:Theme.colorFontSecondary
                            width: layout_item.width
                            visible: model.description !== ""
                        }
                        RowLayout{
                            Layout.leftMargin: 3
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
                        Item{
                            height: 20
                        }
                    }
                }
            }
            Rectangle{
                anchors.fill: listview_serach
                visible: controller.showLoading
                color:Theme.colorBackground1
                CusLoading{
                    anchors.centerIn: parent
                }
            }
        }
    }

    CusMenu{
        id:menu_item
        property var model

        CusMenuItem{
            text:"浏览器打开"
            onClicked: {
                Qt.openUrlExternally("https://github.com/%1/%2".arg(menu_item.model.login).arg(menu_item.model.name))
            }
        }

        function showMenu(val){
            model = val
            popup()
        }
    }


}
