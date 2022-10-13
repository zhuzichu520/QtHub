#include "TextDocument.h"

TextDocument::TextDocument()
{
}

QQuickTextDocument* TextDocument::document() const
{
  return m_document;
}

void TextDocument::setDocument(QQuickTextDocument* document)
{
  if (document != m_document)
  {
    m_document = document;
    textDocument()->setDefaultStyleSheet("a { color:red }");
    emit documentChanged();
  }
}

void TextDocument::insertImage(const QString& path)
{
  QImage image;
  image.load(path);
  QString url = "file:///" + path;
  int width = UiHelper::instance()->getWH(true, image.width(), image.height(), 150);
  int height = UiHelper::instance()->getWH(false, image.width(), image.height(), 150);
  textDocument()->addResource(QTextDocument::ImageResource, QUrl(url), image);
  QTextImageFormat format;
  format.setWidth(width);
  format.setHeight(height);
  format.setName(url);
  textCursor().insertImage(format, QTextFrameFormat::InFlow);
  //    textCursor().insertHtml(QString::fromStdString("<img src=\"%1\" width=\"%2\" height=\"%3\"
  //    />").arg(url).arg(width).arg(height));
}

void TextDocument::insertEmoji(const QString& url)
{
  QFont font;
  font.setPixelSize(14);
  QFontMetrics fmt(font);
  textCursor().insertHtml(QString::fromStdString("<img src=\"%1\" width=\"%2\" height=\"%2\" style=\"vertical-align: "
                                                 "bottom;\" />")
                              .arg(url)
                              .arg(fmt.height()));
}

void TextDocument::clickPosition(int position)
{
}

void TextDocument::insertFile(const QString& path)
{
  QFileInfo fileInfo(path);
  QFileIconProvider provider;
  QIcon icon = provider.icon(fileInfo);

  int width = 540;   // 250
  int height = 100;  // 50

  QPixmap pixmap(width, height);
  QPainter painter(&pixmap);
  painter.setRenderHint(QPainter::Antialiasing, true);
  painter.setBackground(QBrush(Qt::white));

  QPen pen;
  // 画背景
  painter.fillRect(0, 0, width, height, QBrush(Qt::white));
  // 画边框
  pen.setColor(Qt::gray);
  painter.setPen(pen);
  painter.drawRect(QRect(0, 0, width, height));
  // 画ICON
  painter.drawImage(QRect(10, 10, 80, 80), icon.pixmap(QSize(200, 200)).toImage());
  // 绘制文本
  QFont font;
  font.setPixelSize(24);
  QFontMetrics fmt(font);
  painter.setFont(font);
  pen.setColor("#333333");
  painter.setPen(pen);
  QString fileName = fileInfo.fileName();
  int length = fileName.length();
  if (length > 20)
  {
    fileName.remove(10, length - 20);
    fileName.insert(10, "...");
  }
  // 绘制文件名
  painter.drawText(100, 10, fmt.horizontalAdvance(fileName), fmt.height(), Qt::AlignCenter, fileName);  // 位置和内容
  // 绘制文件大小
  QLocale local;
  QString size = local.formattedDataSize(fileInfo.size());
  painter.drawText(100, 50, fmt.horizontalAdvance(size), fmt.height(), Qt::AlignCenter, size);  // 位置和内容
  QImage image = pixmap.toImage();
  QString url = "file:///" + path;
  textDocument()->addResource(QTextDocument::ImageResource, QUrl(url), image);
  QTextImageFormat format;
  format.setWidth(width / 2);
  format.setHeight(height / 2);
  format.setName(url);
  textCursor().insertImage(format, QTextFrameFormat::InFlow);
}

QTextDocument* TextDocument::textDocument() const
{
  if (m_document)
    return m_document->textDocument();
  else
    return nullptr;
}

QTextCursor TextDocument::textCursor()
{
  QTextDocument* doc = textDocument();
  if (!doc)
    return QTextCursor();

  QTextCursor cursor = QTextCursor(doc);
  m_textCurosr = &cursor;
  if (m_selectionStart != m_selectionEnd)
  {
    cursor.setPosition(m_selectionStart);
    cursor.setPosition(m_selectionEnd, QTextCursor::KeepAnchor);
  }
  else
  {
    cursor.setPosition(m_cursorPosition);
  }

  return cursor;
}

int TextDocument::cursorPosition() const
{
  return m_cursorPosition;
}

void TextDocument::setCursorPosition(int position)
{
  if (position != m_cursorPosition)
  {
    m_cursorPosition = position;
    emit cursorPositionChanged();
  }
}

int TextDocument::selectionStart() const
{
  return m_selectionStart;
}

void TextDocument::setSelectionStart(int position)
{
  if (position != m_selectionStart)
  {
    m_selectionStart = position;
    emit selectionStartChanged();
  }
}

int TextDocument::selectionEnd() const
{
  return m_selectionEnd;
}

void TextDocument::setSelectionEnd(int position)
{
  if (position != m_selectionEnd)
  {
    m_selectionEnd = position;
    emit selectionEndChanged();
  }
}

void TextDocument::customPaste()
{
  const QClipboard* clipboard = QGuiApplication::clipboard();
  const QMimeData* mimeData = clipboard->mimeData();
  QString text = "";
  if (mimeData->formats().contains("nicechat/rich"))
  {
    text = mimeData->data("nicechat/rich");
  }
  else if (mimeData->hasUrls())
  {
    text = "hasUrls";
  }
  else if (mimeData->hasHtml())
  {
    text = mimeData->text();
  }
  else if (mimeData->hasText())
  {
    text = mimeData->text();
  }
  else if (mimeData->hasImage())
  {
  }
  else
  {
  }
  QRegularExpression reg(
      "(file:///(?!(.jpg|.png|.jpeg|.gif)).+?(.jpg|.png|.jpeg|.gif))|(qrc:/emojiSvgs/(?!(.svg)).+?(.svg))");
  QStringList list = text.split(reg);
  if (list.size() == 0)
  {
    return;
  }
  if (list.size() == 1)
  {
    textCursor().insertText(list[0]);
    return;
  }
  QRegularExpressionMatchIterator iter = reg.globalMatch(text);
  int i = 0;
  if (list[0] == "")
  {
    // 图片开头
    while (iter.hasNext())
    {
      i++;
      QRegularExpressionMatch match = iter.next();
      QString matched = match.captured(0);
      if (matched.startsWith("file:///"))
      {
        insertImage(matched.mid(8));
      }
      if (matched.startsWith("qrc:/emojiSvgs/"))
      {
        insertEmoji(matched);
      }
      textCursor().insertText(list[i]);
    }
  }
  else
  {
    // 文本开头
    while (iter.hasNext())
    {
      QRegularExpressionMatch match = iter.next();
      QString matched = match.captured(0);
      textCursor().insertText(list[i]);
      if (matched.startsWith("file:///"))
      {
        insertImage(matched.mid(8));
      }
      if (matched.startsWith("qrc:/emojiSvgs/"))
      {
        insertEmoji(matched);
      }
      i++;
    }
    if (list.last() != "")
    {
      textCursor().insertText(list[i]);
    }
  }
}

void TextDocument::customCopy()
{
  int start = textCursor().selectionStart();
  int end = textCursor().selectionEnd();
  LOGI(QString::fromStdString("start->%1,end->%2").arg(start).arg(end).toStdString());
  QTextBlock block = textDocument()->firstBlock();
  int position = 0;
  QString richBuilder;
  QString textBuilder;
  for (QTextBlock::iterator i = block.begin(); !i.atEnd(); ++i)
  {
    QTextFragment fragment = i.fragment();
    QTextCharFormat format = fragment.charFormat();
    if (format.isImageFormat())
    {
      position++;
      QTextImageFormat image = format.toImageFormat();
      if (position > start && position <= end)
      {
        richBuilder.append(image.name());
      }
    }
    else if (format.isCharFormat())
    {
      const QString& text = fragment.text();
      textBuilder.append(text);
      for (int i = 0; i < text.size(); i++)
      {
        position++;
        if (position > start && position <= end)
        {
          richBuilder.append(text.at(i));
        }
      }
    }
  }
  QMimeData* mimeData = new QMimeData;
  mimeData->setData("text/plain", textBuilder.toUtf8());
  mimeData->setData("nicechat/rich", richBuilder.toUtf8());
  QClipboard* clipboard = QGuiApplication::clipboard();
  clipboard->setMimeData(mimeData);
}

QString TextDocument::plainText()
{
  QString plainText;
  QTextBlock block = textDocument()->firstBlock();
  while (block.isValid())
  {
    for (QTextBlock::iterator i = block.begin(); !i.atEnd(); ++i)
    {
      QTextFragment fragment = i.fragment();
      QTextCharFormat format = fragment.charFormat();
      if (format.isImageFormat())
      {
        QTextImageFormat image = format.toImageFormat();
        plainText.append(image.name());
      }
      else if (format.isCharFormat())
      {
        plainText.append(fragment.text());
      }
    }
    block = block.next();
  }
  return plainText;
}
