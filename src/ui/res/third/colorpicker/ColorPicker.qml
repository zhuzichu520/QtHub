import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Rectangle {
    id: colorPicker
    property color colorValue: {
        if(paletteMode === 1)
            return _hsla(hueSlider.value, sbPicker.saturation,
                         sbPicker.brightness, alphaSlider.value)
        if(paletteMode === 0 )
            return _rgb(paletts.paletts_color, alphaSlider.value)
        return finderColor
    }
    property bool enableAlphaChannel: true
    property bool enableDetails: true
    property int colorHandleRadius : 8

    // 0=调色板 1=自定义 3=拾取
    property int paletteMode : 0

    property color fontColor

    property color finderColor : "#000000"


    property string switchToPalleteString: "调色板"
    property string switchToColorPickerString: "自定义"
    property string switchToFindString: "拾取"

    property alias findLayout: findItem.children

    signal colorChanged(color changedColor)

    width: 400; height: 200
    color: "#3C3C3C"
    clip: true

    Row {
        id: palette_switch
        spacing: 14
        anchors{
            left: parent.left
            leftMargin: 14
        }

        Text{
            text: switchToPalleteString
            color:fontColor
            MouseArea{
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    paletteMode = 0
                }
            }
        }

        Text{
            text: switchToColorPickerString
            color:fontColor
            MouseArea{
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    paletteMode = 1
                }
            }
        }

        Text{
            text: switchToFindString
            color:fontColor
            visible: false
            MouseArea{
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    paletteMode = 2
                }
            }
        }
    }

    RowLayout {
        id: picker
        anchors.top: palette_switch.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: colorHandleRadius
        anchors.bottom: parent.bottom
        spacing: 0

        SwipeView {
            id: swipe
            clip: true
            interactive: false
            currentIndex: paletteMode

            Layout.fillWidth: true
            Layout.fillHeight: true


            Palettes {
                id: paletts
            }


            SBPicker {
                id: sbPicker

                height: parent.implicitHeight
                width: parent.implicitWidth
                hueColor: {
                    var v = 1.0-hueSlider.value
                    if(0.0 <= v && v < 0.16) {
                        return Qt.rgba(1.0, 0.0, v/0.16, 1.0)
                    } else if(0.16 <= v && v < 0.33) {
                        return Qt.rgba(1.0 - (v-0.16)/0.17, 0.0, 1.0, 1.0)
                    } else if(0.33 <= v && v < 0.5) {
                        return Qt.rgba(0.0, ((v-0.33)/0.17), 1.0, 1.0)
                    } else if(0.5 <= v && v < 0.76) {
                        return Qt.rgba(0.0, 1.0, 1.0 - (v-0.5)/0.26, 1.0)
                    } else if(0.76 <= v && v < 0.85) {
                        return Qt.rgba((v-0.76)/0.09, 1.0, 0.0, 1.0)
                    } else if(0.85 <= v && v <= 1.0) {
                        return Qt.rgba(1.0, 1.0 - (v-0.85)/0.15, 0.0, 1.0)
                    } else {
                        return "red"
                    }
                }
            }

            Item{
               id:findItem
            }

        }

        // hue picking slider
        Item {
            id: huePicker
            visible: paletteMode === 1
            width: 12
            Layout.fillHeight: true
            Layout.topMargin: colorHandleRadius
            Layout.bottomMargin: colorHandleRadius

            Rectangle {
                anchors.fill: parent
                id: colorBar
                gradient: Gradient {
                    GradientStop { position: 1.0;  color: "#FF0000" }
                    GradientStop { position: 0.85; color: "#FFFF00" }
                    GradientStop { position: 0.76; color: "#00FF00" }
                    GradientStop { position: 0.5;  color: "#00FFFF" }
                    GradientStop { position: 0.33; color: "#0000FF" }
                    GradientStop { position: 0.16; color: "#FF00FF" }
                    GradientStop { position: 0.0;  color: "#FF0000" }
                }
            }
            ColorSlider {
                id: hueSlider; anchors.fill: parent
            }
        }

        // alpha (transparency) picking slider
        Item {
            id: alphaPicker
            visible: enableAlphaChannel
            width: 12
            Layout.leftMargin: 4
            Layout.fillHeight: true
            Layout.topMargin: colorHandleRadius
            Layout.bottomMargin: colorHandleRadius
            Checkerboard { cellSide: 4 }
            //  alpha intensity gradient background
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#FF000000" }
                    GradientStop { position: 1.0; color: "#00000000" }
                }
            }
            ColorSlider {
                id: alphaSlider; anchors.fill: parent
            }
        }

        // details column
        Column {
            id: detailColumn
            Layout.leftMargin: 4
            Layout.fillHeight: true
            Layout.topMargin: colorHandleRadius
            Layout.bottomMargin: colorHandleRadius
            Layout.alignment: Qt.AlignRight
            visible: enableDetails

            // current color/alpha display rectangle
            PanelBorder {
                width: parent.width
                height: 30
                visible: enableAlphaChannel
                Checkerboard { cellSide: 5 }
                Rectangle {
                    width: parent.width; height: 30
                    border.width: 1; border.color: "black"
                    color: colorPicker.colorValue
                }
            }

            // "#XXXXXXXX" color value box
            PanelBorder {
                id: colorEditBox
                height: 15; width: parent.width
                TextInput {
                    anchors.fill: parent
                    color: "#AAAAAA"
                    selectionColor: "#FF7777AA"
                    font.pixelSize: 11
                    maximumLength: 9
                    focus: false
                    text: _fullColorString(colorPicker.colorValue, alphaSlider.value)
                    selectByMouse: true
                }
            }

            // H, S, B color values boxes
            Column {
                visible: paletteMode === 1
                width: parent.width
                NumberBox { caption: "H:"; value: hueSlider.value.toFixed(2) }
                NumberBox { caption: "S:"; value: sbPicker.saturation.toFixed(2) }
                NumberBox { caption: "B:"; value: sbPicker.brightness.toFixed(2) }
            }

            // filler rectangle
            Rectangle {
                width: parent.width; height: 5
                color: "transparent"
            }

            // R, G, B color values boxes
            Column {
                width: parent.width
                NumberBox {
                    caption: "R:"
                    value: _getChannelStr(colorPicker.colorValue, 0)
                    min: 0; max: 255
                }
                NumberBox {
                    caption: "G:"
                    value: _getChannelStr(colorPicker.colorValue, 1)
                    min: 0; max: 255
                }
                NumberBox {
                    caption: "B:"
                    value: _getChannelStr(colorPicker.colorValue, 2)
                    min: 0; max: 255
                }
            }

            // alpha value box
            NumberBox {
                visible: enableAlphaChannel
                caption: "A:"; value: Math.ceil(alphaSlider.value*255)
                min: 0; max: 255
            }
        }
    }

    //  creates color value from hue, saturation, brightness, alpha
    function _hsla(h, s, b, a) {
        var lightness = (2 - s)*b
        var satHSL = s*b/((lightness <= 1) ? lightness : 2 - lightness)
        lightness /= 2

        var c = Qt.hsla(h, satHSL, lightness, a)

        colorChanged(c)

        return c
    }

    // create rgb value
    function _rgb(rgb, a) {

        var c = Qt.rgba(rgb.r, rgb.g, rgb.b, a)

        colorChanged(c)

        return c
    }

    //  creates a full color string from color value and alpha[0..1], e.g. "#FF00FF00"
    function _fullColorString(clr, a) {
        return "#" + ((Math.ceil(a*255) + 256).toString(16).substr(1, 2) + clr.toString().substr(1, 6)).toUpperCase()
    }

    //  extracts integer color channel value [0..255] from color value
    function _getChannelStr(clr, channelIdx) {
        return parseInt(clr.toString().substr(channelIdx*2 + 1, 2), 16)
    }
}
