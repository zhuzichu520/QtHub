import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import Qt.labs.platform 1.1
import Controller 1.0
import "../component"
import "../storage"
import "../global/global.js" as Global
import UI 1.0

CusWindow {
    id:window
    title: "QtHub"
    width: 700
    height: 500
    minimumWidth: 700
    minimumHeight: 500
    closeDestory: false

    property bool showDrawer: true

    MainController{
        id:controller
        onLoginSuccess: {
            show()
        }
    }

    Component.onCompleted: {
        //        navigate(Router.window_login)
    }


    page: CusPage{

        ListModel{
            id:sliderModel
            ListElement{
                name:"首页"
                icon:"\ue68d"
                fontSize:14
                iconSize:20
                url:"qrc:/layout/MainSession.qml"
            }
            ListElement{
                name:"搜索"
                icon:"\ue608"
                fontSize:14
                iconSize:20
                url:"qrc:/layout/MainContact.qml"
            }
        }

        CusToolBar {
            id:toolBar
            topEnable: true
        }

        CusSliderBar{
            id:slider
            width: showDrawer ? 120 : 0
            model: sliderModel
            avatar: userHelper.avatar
            onClickAvatar:{
                if(!userHelper.isLogin()){
                    navigate(Router.window_login)
                    return
                }
                showToast(userHelper.token)
            }
            onClickMenu:{
                id:menu_setting.open()
            }
            Behavior on width {
                NumberAnimation{
                    duration: 500
                    easing{
                        type: Easing.InOutCubic
                    }
                }
            }
        }

        StackLayout{
            id:content
            anchors{
                top:toolBar.bottom
                left: slider.right
                bottom: parent.bottom
                right:parent.right
            }
            currentIndex: slider.getIndex()
            MainHome{
                id:page_home
            }
            MainSearch{
                id:page_search
            }
        }

        Canvas {

            property color themeColor: "#FF2E2E2E"

            id:drawer
            width: 12
            height: 48
            rotation: 180
            opacity: 0.4
            anchors {
                verticalCenter: slider.verticalCenter
                left: slider.right
            }
            contextType: "2d"
            antialiasing: false
            onPaint: {
                context.lineWidth = 2
                context.fillStyle = themeColor
                context.beginPath()
                context.moveTo(0, 12)
                context.lineTo(12, 0)
                context.lineTo(12, 48)
                context.lineTo(0, 36)
                context.lineTo(0, 12)
                context.closePath()
                context.fill()
            }

            onThemeColorChanged: {
                requestPaint()
            }

            Image {
                width: 10
                height: 10
                anchors.centerIn: parent
                source: showDrawer ? "qrc:/image/ic_arrow_right.png" : "qrc:/image/ic_arrow_left.png"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.opacity = 1
                }
                onExited: {
                    parent.opacity = 0.4
                }
                onClicked: {
                    showDrawer = !showDrawer
                }
            }
        }

    }

    CusMenu{
        id:menu_setting
        x:slider.width + window.offset
        y:slider.height - height
        CusMenuItem{
            text:"意见反馈"
            onClicked: {

            }
        }
        CusMenuItem{
            text:"设置"
            onClicked: {
                navigate(Router.window_settings)
            }
        }
    }


}
