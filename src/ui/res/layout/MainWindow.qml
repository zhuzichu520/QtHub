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
                name:"消息"
                icon:"\ue61a"
                fontSize:24
                url:"qrc:/layout/MainSession.qml"
            }
            ListElement{
                name:"联系人"
                icon:"\ue9d2"
                fontSize:24
                url:"qrc:/layout/MainContact.qml"
            }
        }

        CusToolBar {
            id:toolBar
            topEnable: true
        }


        CusSliderBar{
            id:slider
            model: sliderModel
            avatar: "qrc:/image/ic_login_logo.png"
            onClickAvatar:{

            }
            onClickMenu:{
                id:menu_setting.open()
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
