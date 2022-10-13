#ifndef TEXTDOCUMENT_H
#define TEXTDOCUMENT_H

#include <QObject>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QQuickTextDocument>
#include <QJsonArray>
#include <QTextImageFormat>
#include <QTextCursor>
#include <QTextDocumentFragment>
#include <QTextFrame>
#include <QFileIconProvider>
#include <QGuiApplication>
#include <QPainter>
#include <QMimeData>
#include <QFont>
#include <QClipboard>
#include <QTextCharFormat>
#include <QRect>
#include <infrastructure/log/Logger.h>
#include <infrastructure/helper/UiHelper.h>

class TextDocument : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QQuickTextDocument* document READ document WRITE setDocument NOTIFY documentChanged)
  Q_PROPERTY(int cursorPosition READ cursorPosition WRITE setCursorPosition NOTIFY cursorPositionChanged)
  Q_PROPERTY(int selectionStart READ selectionStart WRITE setSelectionStart NOTIFY selectionStartChanged)
  Q_PROPERTY(int selectionEnd READ selectionEnd WRITE setSelectionEnd NOTIFY selectionEndChanged)

public:
  TextDocument();

  QQuickTextDocument* document() const;
  void setDocument(QQuickTextDocument* document);

  int cursorPosition() const;
  void setCursorPosition(int position);

  int selectionStart() const;
  void setSelectionStart(int position);

  int selectionEnd() const;
  void setSelectionEnd(int position);

  Q_INVOKABLE void insertImage(const QString& path);
  Q_INVOKABLE void insertFile(const QString& path);
  Q_INVOKABLE void insertEmoji(const QString& path);

  Q_INVOKABLE QString plainText();

  Q_INVOKABLE void customPaste();

  Q_INVOKABLE void customCopy();

  Q_INVOKABLE void clickPosition(int position);

  QTextDocument* textDocument() const;

  QTextCursor textCursor();

signals:
  void documentChanged();
  void cursorPositionChanged();
  void selectionStartChanged();
  void selectionEndChanged();

private:
  QQuickTextDocument* m_document;
  QTextCursor* m_textCurosr;

  int m_cursorPosition;
  int m_selectionStart;
  int m_selectionEnd;
};

#endif  // TEXTDOCUMENT_H
