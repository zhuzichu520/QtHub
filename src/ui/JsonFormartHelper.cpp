#include "JsonFormartHelper.h"

JsonFormartHelper::JsonFormartHelper(QObject* parent) : QObject{ parent }
{
}

QString JsonFormartHelper::format(const QString &json){
    QJsonParseError *error=new QJsonParseError;
    QJsonDocument jdc = QJsonDocument::fromJson(json.toUtf8(),error);
    if(error->error!=QJsonParseError::NoError){
        return error->errorString();
    }
    return jdc.toJson(QJsonDocument::Indented);

}
