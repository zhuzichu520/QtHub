import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "../component"
import "../storage"
import Controller

CusWindow {
    id:window
    width: 500
    height: 640
    minimumWidth: 500
    minimumHeight: 640
    title: "意见反馈"

    FeedbackController{
        id:controller
    }

    page: CusPage{

        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: false
            title:window.title
        }

        ListView{
            id:listview_feedback
            anchors{
                top: toolBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            clip: true
            boundsBehavior: ListView.StopAtBounds
            footer: Item {
                height: 20
            }
            model: controller.feedbackList
            delegate: Item{
                width: listview_feedback.width
                height: childrenRect.height + 20

                CusAvatar{
                    id:item_avatar
                    width: 40
                    height: 40
                    source:model.avatar
                    anchors{
                        top:parent.top
                        left:parent.left
                        topMargin: 20
                        leftMargin: 20
                    }
                }

                Rectangle{
                    color: "#00000000"
                    border.width: 1
                    border.color: Theme.colorPrimary
                    anchors{
                        left: item_avatar.right
                        leftMargin: 10
                        rightMargin: 20
                        top: item_avatar.top
                        right: parent.right
                    }
                    height: childrenRect.height
                    Layout.fillWidth: true

                    Rectangle{
                        id:item_layout_top
                        height: 36
                        width: parent.width
                        border.color: Theme.colorPrimary
                        color: Qt.alpha(Theme.colorPrimary,0.3)
                        Text{
                            id:item_login
                            text:model.login
                            anchors{
                                left: parent.left
                                leftMargin: 20
                                verticalCenter: parent.verticalCenter
                            }
                        }
                    }

                    Text{
                        id:item_title
                        text: model.title
                        font.pixelSize: 14
                        font.bold: true
                        color:Theme.colorFontPrimary
                        anchors{
                            top: item_layout_top.bottom
                            left: parent.left
                            leftMargin: 20
                            topMargin: 10
                        }
                    }

                    Text{
                        anchors{
                            top: item_title.bottom
                        }
                        font.pixelSize: 12
                        leftPadding: 20
                        rightPadding: 20
                        topPadding: 10
                        bottomPadding: 20
                        color:Theme.colorFontSecondary
                        width: parent.width
                        wrapMode: Text.WrapAnywhere
                        text:model.body
                    }
                }
            }
        }

        Rectangle{
            anchors.fill: listview_feedback
            visible: controller.showLoading
            color:Theme.colorBackground
            CusLoading{
                anchors.centerIn: parent
            }
        }
    }
}
