#include "CommonTool.h"

Q_GLOBAL_STATIC(CommonTool, commonTool)

QRegularExpression Reg_JsonNonNull("/(?:,\"\\w+\":(?:null|""))|(?:\"\\w+\":(?:null|""),)|(?:\"\\w+\":(?:null|""))/g");

CommonTool* CommonTool::instance()
{
    return commonTool;
}

CommonTool::CommonTool(QObject* parent) : QObject{ parent }
{
}

bool CommonTool::isJson(const QString& val)
{
    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(val.toUtf8(), &err);
    if (doc.isNull() || err.error != QJsonParseError::NoError)
    {
        return false;
    }
    return true;
}

QString CommonTool::toBase64(const QString& text)
{
    return text.toUtf8().toBase64();
}

QString CommonTool::fromBase64(const QString& text)
{
    return QByteArray::fromBase64(text.toUtf8());
}

QString CommonTool::md5(const QString& text)
{
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Md5).toHex();
}

QString CommonTool::sha1(const QString& text)
{
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Sha1).toHex();
}

QString CommonTool::sha224(const QString& text)
{
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Sha224).toHex();
}

QString CommonTool::sha256(const QString& text)
{
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Sha256).toHex();
}

QString CommonTool::sha384(const QString& text)
{
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Sha384).toHex();
}

QString CommonTool::sha512(const QString& text)
{
    return QCryptographicHash::hash(text.toUtf8(), QCryptographicHash::Sha512).toHex();
}

qint64 CommonTool::currentTimeMillis()
{
    return QDateTime::currentDateTimeUtc().toMSecsSinceEpoch();
}

QJsonObject CommonTool::string2JsonObject(const std::string& val)
{
    QJsonParseError jsonError;
    QJsonDocument doucment = QJsonDocument::fromJson(QString::fromStdString(val).toUtf8(), &jsonError);
    if (!doucment.isNull() && (jsonError.error == QJsonParseError::NoError))
    {
        return doucment.object();
    }
    return {};
}


void CommonTool::jsonNonNull(QString& val){
    val.replace(Reg_JsonNonNull,"");
}
