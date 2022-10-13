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
    isOpen: false

    MainController{
        id:controller
    }

    onCreateView: {
        navigate(Router.window_login)
    }


}
