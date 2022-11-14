import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "../component"
import "../storage"
import UI

CusWindow {
    id:window
    width: 700
    height: 500
    minimumWidth: 700
    minimumHeight: 500
    title: "JsonFormat"

    JsonFormartHelper{
        id:helper
    }

    page: CusPage{

        Rectangle{
            id:layout_menu
            width: 80
            x:300
            anchors{
                top: toolBar.bottom
                bottom: parent.bottom
            }
            border.width: 1
            border.color: Theme.colorPrimary
            color:Theme.colorBackground

            ColumnLayout{
                width: parent.width
                CusButton{
                    text: "格式化"
                    Layout.topMargin: 100
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        var formatJson = helper.format(edit_left.text)
                        formatJson =formatJson.replace(/( )/g,"&nbsp;")
                        formatJson = formatJson.replace(/(\n)/g,"<br>");
                        formatJson = formatJson.replace(/(")[^"]*":/gi,
                                                        function (match, capture) {
                                                            return "<font color=\"#FF92278F\">"+match+"</font>"
                                                        })
                        edit_right.text = formatJson
                    }
                }
                CusButton{
                    text:"导出"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        helper.exportClass(edit_left.text)
                    }
                }
                CusButton{
                    text:"文件夹"
                    Layout.alignment: Qt.AlignHCenter
                    onClicked: {
                        helper.openDir()
                    }
                }
            }

        }

        ScrollView{
            anchors{
                left: parent.left
                right: layout_menu.left
                top: toolBar.bottom
                bottom: parent.bottom
            }
            CusTextArea{
                id:edit_left
                placeholderText: "请输入Json字符串"
                placeholderTextColor: Theme.colorFontTertiary
            }
        }


        CusToolBar {
            id:toolBar
            darkEnable: false
            topEnable: true
            title:window.title
        }

        ScrollView{
            id:scroll_view
            anchors{
                left: layout_menu.right
                right: parent.right
                top: toolBar.bottom
                bottom: parent.bottom
            }


            CusTextEdit{
                id:edit_right
                wrapMode: Text.WrapAnywhere
                textFormat: Text.RichText
                x:8
                width: scroll_view.width - 16
                font.pixelSize: 14
                onWidthChanged: {
                    text = text
                }
            }
        }
    }
}
