.pragma library

const RouteTable = []
const Windows = {}
var App

const WINDOW_LOGIN = "qrc:/layout/WindowLogin.qml"
const WINDOW_MAIN = "qrc:/layout/WindowMain.qml"
const WINDOW_COLORPICKER = "qrc:/layout/WindowColorPicker.qml"
const WINDOW_SETTINGS = "qrc:/layout/WindowSettings.qml"
const WINDOW_JSONFORMAT = "qrc:/layout/WindowJsonFormat.qml"
const WINDOW_FEEDBACK = "qrc:/layout/WindowFeedback.qml"
const WINDOW_WEBVIEW = "qrc:/layout/WindowWebView.qml"
const WINDOW_SEARCH = "qrc:/layout/WindowSearch.qml"
const WINDOW_ABOUT = "qrc:/layout/WindowAbout.qml"
const WINDOW_REPOSITORIES = "qrc:/layout/WindowRepositories.qml"


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
    RouteTable.push(WINDOW_ABOUT)
    RouteTable.push(WINDOW_REPOSITORIES)
}

function addWindow(winId,window){
    Windows[winId] = window
}

function removeWindow(winId){
    delete Windows[winId]
}

function closeAllWindow(){
    for(var key in Windows){
        Windows[key].close()
    }
}

function obtWindow(path){
    for(var key in Windows){
        if (key.startsWith(path)) {
            return Windows[key]
        }
    }
    return null
}
