import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQml
import "../js/Router.js" as R
import "../component"
import "../storage"

CusWindow {
    id:window
    width: 550
    height: 470
    minimumWidth: 550
    minimumHeight: 470
    title: "设置"

    page: CusPage{

        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: false
            title:window.title
        }

        ListModel{
            id:settinsModel
            ListElement{
                text:"账号设置"
            }
            ListElement{
                text:"通用设置"
            }
            ListElement{
                text:"关于"
            }
        }

        Rectangle{
            id:divider
            width: 1
            color:Theme.colorDivider
            anchors{
                right: settingListView.right
                top: settingListView.top
                bottom: settingListView.bottom
                topMargin: 9
            }
        }

        ListView{
            id:settingListView
            width: 110
            anchors{
                top: toolBar.bottom
                topMargin: 50
                bottom:parent.bottom
                left:parent.left
            }
            model:settinsModel
            delegate: Item{
                width: settingListView.width
                height: 30
                Text{
                    text:model.text
                    color:settingListView.currentIndex === index ? Theme.colorPrimary : Theme.colorFontPrimary
                    font.pixelSize: 13
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        settingListView.currentIndex = index
                    }
                }
                Rectangle{
                    width: 1
                    color:settingListView.currentIndex === index ? Theme.colorPrimary : "#00000000"
                    anchors{
                        right: parent.right
                        top: parent.top
                        topMargin: 9
                        bottomMargin: 8
                        bottom: parent.bottom
                    }
                }
            }
        }

        Loader{
            id:loader
            anchors{
                left: divider.right
                right: parent.right
                top: divider.top
                bottom: divider.bottom
            }
            sourceComponent: {
                switch(settingListView.currentIndex){
                case 0:
                    return comp_account
                case 1:
                    return comp_common
                case 2:
                    return comp_about
                }
            }
        }

    }

    Component{
        id:comp_account
        Item{
            anchors.fill: parent

            Rectangle{
                width: 300
                height: 150
                radius: 5
                color:Theme.colorBackground
                anchors{
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }

                CusAvatar{
                    id:avatar
                    width: 50
                    height: 50
                    source: userHelper.avatar
                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 20
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            console.debug(window.data.lenght)
                        }
                    }
                }

                Text{
                    text: userHelper.name
                    anchors{
                        top: avatar.top
                        left: avatar.right
                        leftMargin: 20
                    }
                    color:Theme.colorFontPrimary
                    font.pixelSize: 18
                }

                Text{
                    text:"账号："+userHelper.account
                    anchors{
                        bottom: avatar.bottom
                        left: avatar.right
                        leftMargin: 20
                    }
                    color:Theme.colorFontTertiary
                    font.pixelSize: 11
                }


            }

            CusButton{
                width: 100
                text: "退出登录"
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    bottom:parent.bottom
                    bottomMargin: 80
                }
                onClicked: {
                    dialog.open()
                }
            }

        }
    }

    Component{
        id:comp_common
        Item{
            anchors.fill: parent
            ColumnLayout{
                anchors{
                    top: parent.top
                    left: parent.left
                    topMargin: 24
                    leftMargin: 24
                }

                RowLayout{

                    Text{
                        font.pixelSize: 12
                        text:"主题颜色"
                        color:Theme.colorFontPrimary
                    }

                    Rectangle{
                        width: 26
                        height: 26
                        color:Theme.colorPrimary
                        MouseArea{
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: {
                                navigate(R.WINDOW_COLORPICKER,{onColorFunc:function(color){
                                    AppStorage.colorPrimary = color
                                }})
                            }
                        }
                    }
                }

                RowLayout {

                    Text{
                        font.pixelSize: 12
                        text:"窗口圆角"
                        color:Theme.colorFontPrimary
                    }

                    CusRadioButton {
                        checked: AppStorage.windowRadiusStep === 0
                        text: qsTr("0")
                        onClicked: {
                            AppStorage.windowRadiusStep = 0
                        }
                    }
                    CusRadioButton {
                        checked: AppStorage.windowRadiusStep === 1
                        text: qsTr("5")
                        onClicked: {
                            AppStorage.windowRadiusStep = 1
                        }
                    }
                    CusRadioButton {
                        checked: AppStorage.windowRadiusStep === 2
                        text: qsTr("10")
                        onClicked: {
                            AppStorage.windowRadiusStep = 2
                        }

                    }
                }


            }
        }
    }

    Component{
        id:comp_about
        Item{
            anchors.fill: parent
            ColumnLayout{
                anchors{
                    top: parent.top
                    left: parent.left
                    topMargin: 24
                    leftMargin: 24
                }

                RowLayout{

                    Text{
                        font.pixelSize: 12
                        text:"版本信息"
                        color:Theme.colorFontPrimary
                    }

                    Column{
                        Text{
                            font.pixelSize: 12
                            text:"Qthub "+Qt.application.version
                            color:Theme.colorFontPrimary
                        }
                        CusButton{
                            text: "检查更新"
                            onClicked: {
                                uiHelper.checkUpdate()
                            }
                        }
                    }


                }



                RowLayout{

                    Text{
                        font.pixelSize: 12
                        text:"个人博客"
                        color:Theme.colorFontPrimary
                    }

                    Text{
                        text: "zhu-zichu.gitee.io"
                        color:Theme.colorPrimary
                        font.underline: true
                        MouseArea{
                            cursorShape: Qt.PointingHandCursor
                            anchors.fill: parent
                            onClicked: {
                                Qt.openUrlExternally("https://zhu-zichu.gitee.io")
                            }
                        }
                    }
                }

            }
        }
    }

    CusTextDialog {
        id: dialog
        message: "确定退出登录？"
        onClickLeft: {
            userHelper.logout()
            R.closeAllWindow()
            navigate(R.WINDOW_LOGIN)
        }
    }

}
