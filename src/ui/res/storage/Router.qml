pragma Singleton

import QtQuick
import QtQuick.Controls

QtObject {

    property string window_login: "qrc:/layout/WindowLogin.qml"
    property string window_main: "qrc:/layout/WindowMain.qml"
    property string window_colorpicker: "qrc:/layout/WindowColorPicker.qml"
    property string window_settings: "qrc:/layout/WindowSettings.qml"
    property string window_jsonformat: "qrc:/layout/WindowJsonFormat.qml"
    property string window_feedback: "qrc:/layout/WindowFeedback.qml"
    property string window_webview: "qrc:/layout/WindowWebView.qml"
    property string window_search: "qrc:/layout/WindowSearch.qml"

    property var router_table: [
        {
            path:window_login,
            onlyOne:true
        },
        {
            path:window_main,
            onlyOne:true
        },
        {
            path:window_settings,
            onlyOne:true
        },
        {
            path:window_colorpicker,
            onlyOne:true
        },
        {
            path:window_jsonformat,
            onlyOne:true
        },
        {
            path:window_feedback,
            onlyOne:true
        },
        {
            path:window_webview,
            onlyOne:true
        },
        {
            path:window_search,
            onlyOne:false
        }
    ]

    property var windows : new Map()

    function obtRouter(path){
        for(var index in router_table){
            var item = router_table[index]
            if(item.path === path){
                return Object.assign({},item)
            }
        }
        return null
    }

    function obtWindow(url){
        for(var key in windows){
            if (key === url) {
                return windows[url]
            }
        }
        return null
    }

    function closeAllWindow(){
        for(var key in windows){
            windows[key].close()
        }
    }

    function addWindow(url,window){
        windows[url] = window
    }

    function removeWindow(url){
        delete windows[url]
    }


    function toUrl(path,isAttach=false,options={}){
        return path+"?isAttach="+isAttach + "&options="+JSON.stringify(options)
    }

    function parseUrl(url){
        let obj = {}
        if (url.indexOf('?') < 0) return obj
        let arr = url.split('?')
        obj.path = arr[0]
        url = arr[1]
        let array = url.split('&')
        for (let i = 0; i < array.length; i++) {
            let arr2 = array[i]
            let arr3 = arr2.split('=')
            obj[arr3[0]] = arr3[1]
        }
        return obj
    }

}
