import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import UI
import Qt5Compat.GraphicalEffects
import "../storage"
import "../global/global.js" as Global
import "../js/Router.js" as R
import "../view"

ApplicationWindow {
    id:window

    property var winId
    property alias page: container.children
    property bool closeDestory: true
    property int titleBarHeight: 30
    property bool isCenter:true
    property int radius: Theme.windowRadius
    //    property int offset: window.visibility === Window.Maximized ? 0 : 5
    property int offset:5
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint | Qt.WindowMinMaxButtonsHint
    visible: true
    color: "#00000000"
    signal createView()

    background: Rectangle{
        color : window.visibility === Window.Maximized ? Theme.colorBackground : "#00000000"
    }

    onClosing:
        (event)=>{
            if(closeDestory){
                window.destroy()
            }
        }

    Component.onCompleted: {
        if(isCenter){
            x = (Screen.width-width)/2
            y = (Screen.height-height)/2
        }
        createView()
        if(winId !== undefined){
            R.addWindow(winId,window)
        }
    }

    Component.onDestruction: {
        if(winId !== undefined){
            R.removeWindow(winId)
        }
    }

    MouseArea{
        width: window.width
        height: titleBarHeight
        acceptedButtons: Qt.LeftButton
        onPressed: window.startSystemMove()
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            leftMargin: offset
            rightMargin: offset
            topMargin: offset
        }
        onDoubleClicked: {
            if(window_resize.fixedSize){
                return
            }
            toggleMaximized()
        }
    }

    Shadow{
        anchors.fill: parent
        anchors.margins: 0
        radius: window.radius
        shadowColor: Theme.colorPrimary
    }

    Rectangle {
        id:container
        anchors.fill: parent
        anchors.margins: offset
        layer.enabled: true
        layer.effect:OpacityMask {
            maskSource: Rectangle {
                width: container.width
                height: container.height
                radius: window.radius
            }
        }
    }

    Toast{
        id:toast
        anchors{
            left: container.left
            right:container.right
            top: container.top
            topMargin: titleBarHeight
        }
    }

    Rectangle{
        id:layoutLoading
        anchors.fill: container
        color: "#33000000"
        visible: false
        CusLoading{
            anchors.centerIn: parent
        }
        z:99
        MouseArea{
            hoverEnabled: true
            anchors.fill: parent
        }
    }

    WindowResize{
        id:window_resize
    }

    function toggleMaximized() {
        if (window.visibility === Window.Maximized) {
            window.showNormal();
        } else {
            window.showMaximized();
        }
    }

    function showToast(text){
        toast.showToast(text)
    }

    function showErrorToast(text){
        toast.showToast(text,Toast.Type.Error)
    }

    function showLoading(){
        layoutLoading.visible = true
    }

    function hideLoading(){
        layoutLoading.visible = false
    }

    function navigateMulti(path,arg={},isChild=false){
        navigate(path,arg,isChild,0);
    }

    function navigateRestart(path,arg={},isChild=false){
        navigate(path,arg,isChild,2);
    }

    function navigate(path,arg={},isChild=false,mode = 1){
        var win = R.obtWindow(path)
        if(win !== null){
            if(mode === 1){
                win.show()
                win.raise()
                win.requestActivate()
                return
            }
            if(mode === 2){
                win.close()
            }
        }
        var comp = app.createComponent(path)
        if (comp.status !== Component.Ready){
            console.error("组件创建错误："+path)
            return
        }
        var options = {winId:path+"_"+uiHelper.uuid()}
        Object.assign(options,arg)
        if(isChild){
            comp.createObject(window,options)
        }else{
            comp.createObject(null,options)
        }
    }

    function getToolBarHeight(){
        return titleBarHeight
    }

    function finish(){
        window.close()
    }

}
