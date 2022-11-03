import QtQuick
import QtQuick.Controls
import QtQuick.Window
import "../component"
import "../storage"

 CusWindow{
    id:app
    visible: false
    Component.onCompleted: {
        navigate(Router.window_main)
    }

    function createWindow(url){
        return Qt.createComponent(url)
    }

}
