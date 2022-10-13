import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Qt.labs.platform 1.1
import Controller 1.0
import "../component"
import "../storage"

CusWindow {
    id:window
    width: 300
    height: 400
    title: "登录"

    LoginController{
        id:controller
    }

    Component.onCompleted: {
        resizable = false
    }

    page: CusPage{

        Image{
            width: 60
            height: 60
            anchors{
                top: parent.top
                topMargin: 60
                horizontalCenter: parent.horizontalCenter
            }
            source: "qrc:/image/ic_login_logo.png"
        }


        Text{
            text:"QtHub"
            anchors{
                top: parent.top
                topMargin: 123
                horizontalCenter: parent.horizontalCenter
            }
            color: "#191E24"
            font.pixelSize: 20
        }

        CusToolBar {
            id:toolBar
            maxEnable: false
            darkEnable: false
            topEnable: false
            isTop: false
            color: "#00000000"
            minHoverColor: "#33000000"
        }

        PrimaryTextField{
            id:edit_account
            width: 260
            height: 36
            lableText: "用户名或邮箱"
            text:"zhuzichu520@gmail.com"
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 183
            }
        }

        PrimaryTextField{
            id:edit_password
            width: 260
            height: 36
            lableText: "密码"
            text:"aA7711451"
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: 240
            }
        }

        Text {
            id: text_error
            color: "#FFCC4125"
            text: controller.textError
            font.pixelSize: 12
            width: edit_password.width
            anchors {
                top: edit_password.bottom
                left: edit_password.left
                topMargin: 3
                leftMargin: 3
            }
            wrapMode: Text.WrapAnywhere
        }

        PrimaryButton{
            id:btn_login
            width: 260
            height: 36
            text:"登录"
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom:parent.bottom
                bottomMargin: 50
            }
            onClicked: {
                Qt.openUrlExternally("https://github.com/login/oauth/authorize?client_id=ebf59d49ca54dae4bda5&redirect_uri=http://localhost:8080/oauth/redirect")
            }
        }
    }
}
