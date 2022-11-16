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

    property var router
    property alias page: container.children
    property int requestCode
    property var prevWindow
    signal windowResult(int requestCode,int resultCode,var data)
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
        if(router !== undefined){
            R.addWindow(router,window)
        }
    }

    Component.onDestruction: {
        if(router !== undefined){
            R.removeWindow(router)
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

    function navigate(router){
        var win = R.obtWindow(router)
        if(win !== null){
            win.show()
            win.raise()
            win.requestActivate()
            return
        }
        var comp = app.createComponent(router)
        if (comp.status !== Component.Ready){
            console.error("组件创建错误："+router)
            return
        }
        var options = {router:router}
        comp.createObject(null,options)
    }

    //    function navigate(url,param={},attach=false,requestCode = 0){
    //        if (url.indexOf('?') < 0){
    //            url = Router.toUrl(url,attach,param)
    //        }
    //        var obj = Router.parseUrl(url)
    //        var path = obj.path;
    //        var isAttach = obj.isAttach.bool();
    //        var options = JSON.parse(obj.options)
    //        var data = Router.obtRouter(path)
    //        if(data === null){
    //            console.error("没有注册当前路由："+path)
    //            return
    //        }
    //        var win = Router.obtWindow(url)
    //        console.debug("------------>"+data.onlyOne)
    //        if(win !== null && data.onlyOne){
    //            win.show()
    //            win.raise()
    //            win.requestActivate()
    //            return
    //        }
    //        options.requestCode = requestCode
    //        options.prevWindow = window
    //        var comp = app.createWindow(data.path)
    //        if (comp.status !== Component.Ready){
    //            console.error("组件创建错误："+path)
    //            return
    //        }
    //        data.url = url
    //        options.router = data

    //        if(!isAttach){
    //            win =comp.createObject(null,options)
    //        }else{
    //            win = comp.createObject(window,options)
    //        }
    //    }

    function setResult(resultCode,data){
        prevWindow.windowResult(requestCode,resultCode,data)
    }

    function getToolBarHeight(){
        return titleBarHeight
    }

    function finish(){
        window.close()
    }

    function updateWindow(){
        width =- 1
        width =+ 1
    }

}
