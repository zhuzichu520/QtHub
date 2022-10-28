import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import UI
import Qt5Compat.GraphicalEffects
import "../storage"
import "../global/global.js" as Global

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
    property int radius: 5
    property int offset: window.visibility === Window.Maximized ? 0 : 5
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint
    color: "#00000000"
    signal createView()

    onClosing: function(closeevent){
        try{
            if(closeDestory){
                window.destroy()
            }else{
                window.visible = false
            }
            closeevent.accepted = false
        }catch(err){
            //            window.destroy()
            //            closeevent.accepted = false
        }
    }

    Component.onCompleted: {
        if(isCenter){
            x = (Screen.width-width)/2
            y = (Screen.height-height)/2
        }
        createView()
        if(window.router !== undefined){
            Router.addWindow(router.url,window)
        }
    }

    Component.onDestruction: {
        if(router !== undefined){
            Router.removeWindow(window.router.url)
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

    function navigate(url,requestCode = 0){
        if (url.indexOf('?') < 0){
            url = Router.toUrl(url)
        }
        var obj = Router.parseUrl(url)
        var path = obj.path;
        var isAttach = obj.isAttach.bool();
        var options = JSON.parse(obj.options)
        var data = Router.obtRouter(path)
        if(data === null){
            console.error("没有注册当前路由："+path)
            return
        }
        var win = Router.obtWindow(url)
        if(win !== null && data.onlyOne){
            for(var key in options){
                win[key] = options[key]
            }
            options.requestCode = requestCode
            options.prevWindow = window
            win.show()
            win.raise()
            win.requestActivate()
            return
        }
        options.requestCode = requestCode
        options.prevWindow = window
        var comp = Qt.createComponent(data.path)
        if (comp.status !== Component.Ready){
            console.error("组件创建错误："+path)
            return
        }
        data.url = url
        options.router = data

        if(!isAttach){
            win = comp.createObject(null,options)
        }else{
            win = comp.createObject(window,options)
        }
    }

    function setResult(resultCode,data){
        prevWindow.windowResult(requestCode,resultCode,data)
    }

    function setHitTestVisible(view,isHit){

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
