import QtQuick 2.15
import QtQuick.Controls 2.15
import "../storage"
import UI 1.0

TextArea {

    id:input_text
    selectionColor: "#9BCAEF"
    selectByMouse: true
    selectByKeyboard: true
    textFormat: Text.PlainText

    onLinkActivated: {
        console.debug("activated"+link)
    }

    TextDocument{
        id:doc
        document: input_text.textDocument
        cursorPosition: input_text.cursorPosition
        selectionStart: input_text.selectionStart
        selectionEnd: input_text.selectionEnd
    }

    function plainText(){
        return doc.plainText()
    }

    function customPaste(){
        doc.customPaste()
    }

    function customCopy(){
        doc.customCopy()
    }

    function insertImage(url){
        doc.insertImage(url)
    }

    function insertFile(url){
        doc.insertFile(url)
    }

    function clickPosition(position){
        doc.clickPosition(position)
    }

    function insertEmoji(url){
        doc.insertEmoji(url)
    }

}
