import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import UI
import "../storage"
import "../global/global.js" as Global

ApplicationWindow {
    id:window

    property var router
    property alias page: container.children
    property int requestCode
    property var prevWindow
    property var resizable
    signal windowResult(int requestCode,int resultCode,var data)
    property bool closeDestory: true
    property int titleBarHeight: 30
    property int offsetW:0
    visible: false
    property int offsetH:0
    property bool isCenter:true
    property bool isOpen: true

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

    onResizableChanged: {
        if(resizable){
            minimumWidth = 0
            minimumHeight = 0
            maximumWidth = 16777215
            maximumHeight = 16777215
        }else{
            minimumWidth = width
            minimumHeight = height
            maximumWidth = width
            maximumHeight = height
        }
        flags = flags | Qt.WindowStaysOnTopHint
        flags = flags &~ Qt.WindowStaysOnTopHint
    }

    Component.onCompleted: {
        framelessHelper.titleBarHeight = window.titleBarHeight
        var rawW = window.width
        var rawH = window.height
        framelessHelper.removeWindowFrame()
        width = rawW + 1
        height = rawH
        width = rawW  - 1
        if(isCenter){
            x = (Screen.width-width)/2
            y = (Screen.height-height)/2
        }
        flags = flags | Qt.WindowStaysOnTopHint
        flags = flags &~ Qt.WindowStaysOnTopHint
        createView()
        if(window.router !== undefined){
            Router.addWindow(router.url,window)
        }
        if(isOpen){
            show()
            window.raise()
            window.requestActivate()
        }
    }

    Component.onDestruction: {
        if(router !== undefined){
            Router.removeWindow(window.router.url)
        }
    }

    FramelessHelper {
        id: framelessHelper
    }

    Item {
        id:container
        anchors.fill: parent
        MouseArea{
            anchors.fill: parent
        }
    }

    Rectangle{
        anchors.fill: parent
        color:"#00000000"
        border.width: 1
        visible: appConfig.isLinux()
        border.color: Theme.colorPrimary
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
        framelessHelper.setHitTestVisible(view, isHit)
    }

    function getToolBarHeight(){
        return framelessHelper.titleBarHeight
    }

    function finish(){
        window.close()
    }

}
