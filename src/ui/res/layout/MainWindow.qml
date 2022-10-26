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
    isOpen: true

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

        Image{
            id:img_logo
            width: 60
            height: 60
            anchors{
                top: parent.top
                topMargin: 100
                horizontalCenter: parent.horizontalCenter
            }
            source: "qrc:/image/ic_login_logo.png"
        }


        TextArea{
            text: settingsHelper.getToken()
            anchors{
                top: img_logo.bottom
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }
            readOnly: true
            selectByMouse: true
            color: "#191E24"
            font.pixelSize: 20
        }

        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: false
            isTop: false
        }


    }


}
