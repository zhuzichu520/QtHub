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
    width: 560
    height: 640
    minimumWidth: 560
    minimumHeight: 640
    title: "搜索"

    property var model_sort: [{"text":"最佳匹配","sort":"best match"},{"text":"最多stars","sort":"stars"},{"text":"最多forks","sort":"forks"},{"text":"最多watches","sort":"watches"},{"text":"最近更新","sort":"updated"}]
    property int sortIndex: 0
    property string keyword

    SearchController{
        id:controller
    }

    function sort(){
        return model_sort[sortIndex].sort
    }

    Component.onCompleted: {
        controller.search(keyword,1,10,sort())
    }

    page: CusPage{

        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: true
            title:window.title
        }

        Item{
            id:layout_bar
            height: 42
            width: parent.width
            anchors.top: toolBar.bottom

            TextField{
                id:edit_search
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: btn_search.left
                    rightMargin: 10
                }
                width: 200
                selectionColor: Qt.alpha(Theme.colorPrimary,0.3)
                selectByMouse: true
                verticalAlignment: TextInput.AlignVCenter
                selectedTextColor: color
                height: 30
                background: Rectangle{
                    radius: 3
                    border{
                        width: 1
                        color: edit_search.focus ? Theme.colorPrimary : "#BBBBBB"
                    }
                }
            }

            PrimaryButton{
                id:btn_search
                text:"搜索"
                width: 50
                height: 25
                anchors{
                    right: parent.right
                    rightMargin: 15
                    verticalCenter: parent.verticalCenter
                }
                onClicked: {
                    var q = edit_search.text
                    if(q===""){
                        showErrorToast("请输入搜索关键字！")
                        return
                    }
                    keyword = q
                    controller.search(keyword,1,10,sort())
                }
            }

            CusButton{
                text: "排序：%1".arg(model_sort[sortIndex].text)
                height: 30
                anchors{
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 15
                }
                onClicked: {
                    menu_sort.showMenu()
                }
            }

        }

        Rectangle{
            id:layout_list
            anchors{
                top: layout_bar.bottom
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
                        highlightedColor:Theme.colorPrimary
                        onRequestPage: {
                            controller.search(keyword,page,count,sort())
                        }
                    }
                    Connections{
                        target: window
                        function onSortIndexChanged(val){
                            pagination.pageCurrent = 1
                        }
                        function onKeywordChanged(val){
                            pagination.pageCurrent = 1
                        }
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
                        Flow{
                            spacing: 10
                            Layout.fillWidth: true
                            Repeater{
                                model:topics
                                delegate: CusButton{
                                    text: modelData
                                    radius: 15
                                    height: 30
                                    onClicked: {
                                        showToast("功能还在建设中...")
                                    }
                                }
                            }
                        }
                        RowLayout{
                            Layout.leftMargin: 3
                            spacing: 0
                            TextIcon{
                                text: "\ue8bc"
                                color:Theme.colorFontSecondary
                                font.pixelSize: 14
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Text{
                                text: model.starNumber
                                color:Theme.colorFontSecondary
                                font.pixelSize: 12
                                Layout.leftMargin: 2
                                Layout.alignment: Qt.AlignVCenter
                            }
                            Rectangle{
                                width: 12
                                height: 12
                                radius: 6
                                visible: model.language !== ""
                                Layout.alignment: Qt.AlignVCenter
                                Layout.leftMargin: 10
                                color:uiHelper.getLanguageColor(model.language)
                            }
                            Text{
                                text: qsTr(model.language)
                                Layout.alignment: Qt.AlignVCenter
                                color:Theme.colorFontSecondary
                                Layout.leftMargin: 2
                                font.pixelSize: 12
                            }
                            Text{
                                text: qsTr(model.updatedAt)
                                Layout.alignment: Qt.AlignVCenter
                                color:Theme.colorFontSecondary
                                Layout.leftMargin: 10
                                font.pixelSize: 12
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

    CusMenu{
        id:menu_sort
        width: 120
        Repeater{
            model: model_sort
            delegate: CusMenuItem{
                text:modelData.text
                onClicked: {
                    sortIndex = index
                    controller.search(keyword,1,10,sort())
                }
            }
        }
        function showMenu(){
            popup()
        }
    }

}
