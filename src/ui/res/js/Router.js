.pragma library

const WINDOW_LOGIN = "qrc:/layout/WindowLogin.qml"
const WINDOW_MAIN = "qrc:/layout/WindowMain.qml"
const WINDOW_COLORPICKER = "qrc:/layout/WindowColorPicker.qml"
const WINDOW_SETTINGS = "qrc:/layout/WindowSettings.qml"
const WINDOW_JSONFORMAT = "qrc:/layout/WindowJsonFormat.qml"
const WINDOW_FEEDBACK = "qrc:/layout/WindowFeedback.qml"
const WINDOW_WEBVIEW = "qrc:/layout/WindowWebView.qml"
const WINDOW_SEARCH = "qrc:/layout/WindowSearch.qml"

const RouteTable = []

const Windows = {}

var App

function init(app) {
    App = app
    RouteTable.push(WINDOW_LOGIN)
    RouteTable.push(WINDOW_MAIN)
    RouteTable.push(WINDOW_COLORPICKER)
    RouteTable.push(WINDOW_SETTINGS)
    RouteTable.push(WINDOW_JSONFORMAT)
    RouteTable.push(WINDOW_FEEDBACK)
    RouteTable.push(WINDOW_WEBVIEW)
    RouteTable.push(WINDOW_SEARCH)
}

function addWindow(router,window){
    Windows[router] = window
}

function removeWindow(router){
    delete Windows[router]
}

function obtWindow(router){
    for(var key in Windows){
        if (key === router) {
            return Windows[url]
        }
    }
    return null
}
