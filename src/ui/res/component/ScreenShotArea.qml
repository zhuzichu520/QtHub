import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import UI 1.0
import "../storage"
import "../global/global.js" as Global

Item {

    id:root
    property int startX
    property int startY
    property int endX
    property int endY
    property string maskColor: "#88000000"
    property string borderColor: "#FF1AAD19"
    property string dragColor : "#FF1AAD19"
    property bool enableSelect: true
    property bool showMenu: false
    signal clipClicked
    anchors.fill: parent

    //0:move 1:arrow 2:rect 3:ellipse
    property int type : 0

    FontLoader {
        id: awesome
        source: "qrc:/font/screenshot.ttf"
    }

    Rectangle{
        id:mask_top
        color: maskColor
        anchors{
            top: parent.top
            bottom: rect_select.top
            left: parent.left
            right: parent.right
        }
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: {
                rightButton()
            }
        }
    }

    Rectangle{
        id:mask_left
        color: maskColor
        anchors{
            top: rect_select.top
            bottom: rect_select.bottom
            left: parent.left
            right: rect_select.left
        }
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: {
                rightButton()
            }
        }
    }

    Rectangle{
        id:mask_right
        color: maskColor
        anchors{
            top: rect_select.top
            bottom: rect_select.bottom
            left: rect_select.right
            right: parent.right
        }
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: {
                rightButton()
            }
        }
    }

    Rectangle{
        id:mask_bottom
        color: maskColor
        anchors{
            top: rect_select.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked: {
                rightButton()
            }
        }
    }

    Rectangle{
        id:rect_select
        color: "#00000000"
        width: 0
        height: 0
        x:-1
        y:-1
        border{
            width: 1
            color: borderColor
        }
    }

    MouseArea{
        anchors.fill: rect_select
        cursorShape: Qt.SizeAllCursor
        drag.target: rect_select
        drag.axis: Drag.XAndYAxis
        drag.minimumX: 0
        visible: type === 0
        drag.maximumX: root.width - rect_select.width
        drag.minimumY: 0
        drag.maximumY: root.height - rect_select.height
        acceptedButtons: Qt.AllButtons
        onClicked:(mouse)=> {
                      if(mouse.button === Qt.RightButton){
                          rightButton()
                      }
                  }
    }

    property var paintDatas : []

    Item{
        id:rect_clip
        anchors.fill: rect_select

        PixmapImage{
            id:image_clip
            anchors.fill: parent
            source: helper.clipPixmap
        }

        Canvas{
            id:canvas
            property string strokeStyle: "#FFFF1E10"
            property string fillStyle: "#FFFF1E10"
            property int lineWidth: 2
            property int  arrowWidth: 4
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.save();
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                ctx.strokeStyle = canvas.strokeStyle
                ctx.fillStyle = canvas.fillStyle
                ctx.lineWidth = canvas.lineWidth
                paintDatas.forEach(function(item){
                    if(item.type === 1){
                        ctx.beginPath()
                        var side = arrowWidth * 2;
                        var startX = item.x
                        var startY = item.y
                        var endX = item.x+item.width
                        var endY = item.y+item.height
                        var referLength = side * 2
                        var lineLength = Math.sqrt((startX-endX)*(startX-endX)+(startY-endY)*(startY-endY))
                        var realSide = (arrowWidth/ referLength)*lineLength
                        if(realSide > side)
                        {
                            realSide = side
                        }
                        var height = realSide * Math.sin(40.0/180.0*Math.PI)
                        var qatan2 = Math.atan2(endY-startY,endX-startX)
                        var angle = qatan2*180/Math.PI
                        var cx = startX + (lineLength-height)*Math.cos(angle/180.0*Math.PI)
                        var cy = startY + (lineLength-height)*Math.sin(angle/180.0*Math.PI)
                        var ocx = startX + (lineLength-height*0.7)*Math.cos(angle/180.0*Math.PI)
                        var ocy = startY + (lineLength-height*0.7)*Math.sin(angle/180.0*Math.PI)
                        ctx.moveTo(startX,startY)
                        var upAngle = angle - 90
                        var upX1 = ocx + realSide*0.4/2*Math.cos(upAngle/180.0*Math.PI)
                        var upY1 = ocy + realSide*0.4/2*Math.sin(upAngle/180.0*Math.PI)
                        ctx.lineTo(upX1,upY1)
                        var upX2 = cx + realSide/2*Math.cos(upAngle/180.0*Math.PI)
                        var upY2 = cy + realSide/2*Math.sin(upAngle/180.0*Math.PI)
                        ctx.lineTo(upX2,upY2)
                        ctx.lineTo(endX,endY)
                        var downAngle = angle + 90
                        var downX2 = cx + realSide/2*Math.cos(downAngle/180.0*Math.PI)
                        var downY2 = cy + realSide/2*Math.sin(downAngle/180.0*Math.PI)
                        ctx.lineTo(downX2,downY2)
                        var downX1 = ocx + realSide*0.4/2*Math.cos(downAngle/180.0*Math.PI)
                        var downY1 = ocy + realSide*0.4/2*Math.sin(downAngle/180.0*Math.PI)
                        ctx.lineTo(downX1,downY1);
                        ctx.lineTo(startX,startY);
                        ctx.fill()
                    }else if(item.type === 2){
                        ctx.beginPath()
                        var w = item.width
                        var h = item.height
                        if(w===0){w = 1}
                        if(h===0){h = 1}
                        ctx.rect(item.x,item.y,w,h)
                        ctx.stroke()
                    }else if(item.type === 3){
                        ctx.beginPath()
                        ctx.ellipse(item.x,item.y,item.width,item.height)
                        ctx.stroke()
                    }
                })
                ctx.restore()
            }
        }

    }


    MouseArea{
        id:mouse_canvas
        property var obj
        property int startX
        property int startY
        anchors.fill: rect_select
        cursorShape: Qt.ArrowCursor
        visible: type !== 0
        onPressed: {
            startX = mouse.x
            startY = mouse.y
            obj = {'type':type,'x':startX,'y':startY,'width':0,'height':0}
            paintDatas.push(obj)
            canvas.requestPaint()
        }
        onReleased: {

        }
        onPositionChanged: {
            obj.width = mouse.x - startX
            obj.height = mouse.y - startY
            canvas.requestPaint()
        }
    }

    MouseArea{
        anchors.fill: parent
        enabled: enableSelect
        onPressed:
            (mouse)=> {
                startX = mouse.x
                startY = mouse.y
                rect_select.x = startX
                rect_select.y = startY
                rect_select.width = 0
                rect_select.height = 0
                mouse.accepted = true
            }
        onReleased:
            (mouse)=> {
                enableSelect = false
                showMenu = true
                rect_menu.x = Qt.binding(function(){
                    return rect_select.x + rect_select.width - rect_menu.width
                })
                rect_menu.y = Qt.binding(function(){
                    var offsetY = rect_select.y + rect_select.height + 10
                    if(offsetY+rect_menu.height>root.height){
                        offsetY = rect_select.y -  rect_menu.height - 10
                        if(offsetY < 0){
                            return rect_select.y + rect_select.height - rect_menu.height - 10
                        }else{
                            return offsetY
                        }
                    }else{
                        return offsetY
                    }
                })
            }
        onPositionChanged:
            (mouse)=> {
                if(mouse.x>=startX && mouse.y>=startY){
                    rect_select.x = startX
                    rect_select.y = startY
                    rect_select.width = mouse.x - rect_select.x
                    rect_select.height = mouse.y - rect_select.y
                }
                if(mouse.x<=startX && mouse.y>=startY){
                    rect_select.x = mouse.x
                    rect_select.y = startY
                    rect_select.width = startX - rect_select.x
                    rect_select.height = mouse.y - rect_select.y
                }
                if(mouse.x>=startX && mouse.y<=startY){
                    rect_select.x = startX
                    rect_select.y = mouse.y
                    rect_select.width = mouse.x - rect_select.x
                    rect_select.height = startY - rect_select.y
                }
                if(mouse.x<=startX && mouse.y<=startY){
                    rect_select.x = mouse.x
                    rect_select.y = mouse.y
                    rect_select.width = startX - rect_select.x
                    rect_select.height = startY - rect_select.y
                }
                mouse.accepted = true
            }
    }

    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            left: rect_select.left
            leftMargin: -1
            top:rect_select.top
            topMargin: -1
        }
        MouseArea{
            property point startPoint: "0,0"
            property point endPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeFDiagCursor
            onPressed:
                (mouse) => {
                    startPoint = Qt.point(rect_select.x, rect_select.y)
                    endPoint = Qt.point(rect_select.x+rect_select.width, rect_select.y+rect_select.height)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.x<endPoint.x && pos.y<endPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = pos.y
                        rect_select.width = endPoint.x - rect_select.x
                        rect_select.height = endPoint.y - rect_select.y
                    }
                    if(pos.x>endPoint.x && pos.y>endPoint.y){
                        rect_select.x = endPoint.x
                        rect_select.y = endPoint.y
                        rect_select.width = pos.x - rect_select.x
                        rect_select.height = pos.y - rect_select.y
                    }
                    if(pos.x<endPoint.x && pos.y>endPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = endPoint.y
                        rect_select.width = endPoint.x - rect_select.x
                        rect_select.height = pos.y - rect_select.y
                    }
                    if(pos.x>endPoint.x && pos.y<endPoint.y){
                        rect_select.x = endPoint.x
                        rect_select.y = pos.y
                        rect_select.width = pos.x - rect_select.x
                        rect_select.height = endPoint.y - rect_select.y
                    }
                }
        }
    }

    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            top:rect_select.top
            topMargin: -1
            horizontalCenter: rect_select.horizontalCenter
        }
        MouseArea{
            property point endPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeVerCursor
            onPressed:
                (mouse) => {
                    endPoint = Qt.point(rect_select.x+rect_select.width, rect_select.y+rect_select.height)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.y<endPoint.y){
                        rect_select.y = pos.y
                        rect_select.height = endPoint.y - rect_select.y
                    }else{
                        rect_select.y = endPoint.y
                        rect_select.height = pos.y - rect_select.y
                    }
                }
        }
    }

    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            right: rect_select.right
            rightMargin: -1
            top:rect_select.top
            topMargin: -1
        }
        MouseArea{
            property point startPoint: "0,0"
            property point endPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeBDiagCursor
            onPressed:
                (mouse) => {
                    startPoint = Qt.point(rect_select.x, rect_select.y)
                    endPoint = Qt.point(rect_select.x+rect_select.width, rect_select.y+rect_select.height)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.x>startPoint.x && pos.y<endPoint.y){
                        rect_select.x = startPoint.x
                        rect_select.y = pos.y
                        rect_select.width = pos.x - startPoint.x
                        rect_select.height = endPoint.y - pos.y
                    }
                    if(pos.x<startPoint.x && pos.y>endPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = endPoint.y
                        rect_select.width =  startPoint.x -  pos.x
                        rect_select.height = pos.y -  endPoint.y
                    }
                    if(pos.x<startPoint.x && pos.y<endPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = pos.y
                        rect_select.width = startPoint.x - pos.x
                        rect_select.height = endPoint.y - pos.y
                    }
                    if(pos.x>startPoint.x && pos.y>endPoint.y){
                        rect_select.x = startPoint.x
                        rect_select.y = endPoint.y
                        rect_select.width =  pos.x -  startPoint.x
                        rect_select.height = pos.y -  endPoint.y
                    }
                }
        }
    }

    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            left: rect_select.left
            leftMargin: -1
            bottom:rect_select.bottom
            bottomMargin: -1
        }
        MouseArea{
            property point startPoint: "0,0"
            property point endPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeBDiagCursor
            onPressed:
                (mouse) => {
                    startPoint = Qt.point(rect_select.x, rect_select.y)
                    endPoint = Qt.point(rect_select.x+rect_select.width, rect_select.y+rect_select.height)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.x<endPoint.x && pos.y>startPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = startPoint.y
                        rect_select.width = endPoint.x - pos.x
                        rect_select.height = pos.y -  startPoint.y
                    }
                    if(pos.x>endPoint.x && pos.y<startPoint.y){
                        rect_select.x = endPoint.x
                        rect_select.y = pos.y
                        rect_select.width = pos.x - endPoint.x
                        rect_select.height = startPoint.y - pos.y
                    }
                    if(pos.x>endPoint.x && pos.y>startPoint.y){
                        rect_select.x = endPoint.x
                        rect_select.y = startPoint.y
                        rect_select.width = pos.x - endPoint.x
                        rect_select.height = pos.y -  startPoint.y
                    }
                    if(pos.x<endPoint.x && pos.y<startPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = pos.y
                        rect_select.width = endPoint.x - pos.x
                        rect_select.height = startPoint.y -  pos.y
                    }
                }
        }
    }

    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            bottom:rect_select.bottom
            bottomMargin: -1
            horizontalCenter: rect_select.horizontalCenter
        }
        MouseArea{
            property point startPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeVerCursor
            onPressed:
                (mouse) => {
                    startPoint = Qt.point(rect_select.x, rect_select.y)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.y>startPoint.y){
                        rect_select.y = startPoint.y
                        rect_select.height = pos.y - rect_select.y
                    }else{
                        rect_select.y = pos.y
                        rect_select.height = startPoint.y - rect_select.y
                    }
                }
        }
    }

    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            right: rect_select.right
            rightMargin: -1
            bottom:rect_select.bottom
            bottomMargin: -1
        }
        MouseArea{
            property point startPoint: "0,0"
            property point endPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeFDiagCursor
            onPressed:
                (mouse) => {
                    startPoint = Qt.point(rect_select.x, rect_select.y)
                    endPoint = Qt.point(rect_select.x+rect_select.width, rect_select.y+rect_select.height)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.x>startPoint.x && pos.y>startPoint.y){
                        rect_select.x = startPoint.x
                        rect_select.y = startPoint.y
                        rect_select.width = pos.x - rect_select.x
                        rect_select.height = pos.y - rect_select.y
                    }
                    if(pos.x<startPoint.x && pos.y<startPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = pos.y
                        rect_select.width = startPoint.x - pos.x
                        rect_select.height = startPoint.y - pos.y
                    }
                    if(pos.x<startPoint.x && pos.y>startPoint.y){
                        rect_select.x = pos.x
                        rect_select.y = startPoint.y
                        rect_select.width = startPoint.x - pos.x
                        rect_select.height = pos.y - rect_select.y
                    }
                    if(pos.x>startPoint.x && pos.y<startPoint.y){
                        rect_select.x = startPoint.x
                        rect_select.y = pos.y
                        rect_select.width = pos.x - startPoint.x
                        rect_select.height = startPoint.y - pos.y
                    }
                }
        }
    }



    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            right: rect_select.right
            rightMargin: -1
            verticalCenter: rect_select.verticalCenter
        }
        MouseArea{
            property point startPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeHorCursor
            onPressed:
                (mouse) => {
                    startPoint = Qt.point(rect_select.x, rect_select.y)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.x>startPoint.x){
                        rect_select.x = startPoint.x
                        rect_select.width = pos.x - rect_select.x
                    }else{
                        rect_select.x = pos.x
                        rect_select.width = startPoint.x - rect_select.x
                    }
                }
        }
    }

    Rectangle{
        width: 4
        height: 4
        color: dragColor
        anchors{
            left: rect_select.left
            leftMargin: -1
            verticalCenter: rect_select.verticalCenter
        }
        MouseArea{
            property point endPoint: "0,0"
            anchors.fill: parent
            cursorShape: Qt.SizeHorCursor
            onPressed:
                (mouse) => {
                    endPoint = Qt.point(rect_select.x+rect_select.width, rect_select.y+rect_select.height)
                }
            onPositionChanged:
                (mouse) => {
                    var pos = parent.mapToItem(parent.parent,mouseX,mouseY)
                    if(pos.x<endPoint.x){
                        rect_select.x = pos.x
                        rect_select.width = endPoint.x - rect_select.x
                    }else{
                        rect_select.x = endPoint.x
                        rect_select.width = pos.x - rect_select.x
                    }
                }
        }
    }

    Rectangle{
        id:rect_menu
        width: childrenRect.width
        height: childrenRect.height
        visible: showMenu
        RowLayout{
            CusToolButton {
                id:btn_rect
                color:type === 2 ? Theme.colorPrimary : "#FF4C4C4C"
                icon:"\ue906"
                tipText: "方框"
                fontFamily:awesome.name
                iconSize: 18
                Layout.leftMargin: 10
                onClickEvent: {
                    if(type === 2){
                        type = 0
                        return
                    }
                    type = 2
                }
            }

            CusToolButton {
                id:btn_ellipse
                color: type === 3 ? Theme.colorPrimary : "#FF4C4C4C"
                icon:"\ue903"
                tipText: "椭圆"
                fontFamily:awesome.name
                iconSize: 18
                onClickEvent: {
                    if(type === 3){
                        type = 0
                        return
                    }
                    type = 3
                }
            }

            CusToolButton {
                id:btn_arrow
                color: type === 1 ? Theme.colorPrimary : "#FF4C4C4C"
                icon:"\ue900"
                tipText: "箭头"
                fontFamily:awesome.name
                iconSize: 18
                onClickEvent: {
                    if(type === 1){
                        type = 0
                        return
                    }
                    type = 1
                }
            }


            CusToolButton {
                id:btn_close
                color: "#FFF95353"
                icon:"\ue904"
                tipText: "取消"
                fontFamily:awesome.name
                iconSize: 18
                onClickEvent: {
                    Window.window.close()
                }
            }

            CusToolButton {
                id:btn_clip
                color: "#FF07C140"
                icon:"\ue902"
                tipText: "完成"
                iconSize: 18
                Layout.rightMargin: 10
                fontFamily:awesome.name
                onClickEvent: {
                    helper.captureRect(getAreaX(),getAreaY(),getAreaWidth(),getAreaHeight())
                    rect_clip.grabToImage(function(result) {
                        result.saveToFile("demo.png");
                        Window.window.close()
                    });
                }
            }
        }
    }

    function rightButton(){
        if(enableSelect){
            Window.window.close()
        }else{
            retrunParam()
        }
    }

    function getAreaX(){
        return (rect_select.x)*Screen.devicePixelRatio
    }

    function getAreaY(){
        return (rect_select.y)*Screen.devicePixelRatio
    }

    function getAreaWidth(){
        return (rect_select.width)*Screen.devicePixelRatio
    }

    function getAreaHeight(){
        return (rect_select.height)*Screen.devicePixelRatio
    }

    function retrunParam(){
        paintDatas = []
        root.type = 0
        rect_select.width=0
        rect_select.height=0
        rect_select.x=-4
        rect_select.y=-4
        enableSelect = true
        showMenu = false
    }

}
