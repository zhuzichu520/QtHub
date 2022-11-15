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

void JsonFormartHelper::exportClass(const QString &json){
    QJsonParseError *error=new QJsonParseError;
    QJsonDocument jdc = QJsonDocument::fromJson(json.toUtf8(),error);
    if(error->error!=QJsonParseError::NoError){
        return;
    }
    if(jdc.isObject()){
        const QJsonObject &object = jdc.object();
        loadCpp("ResultDto",object);
    }else{
        const QJsonArray &arr =  jdc.array();
        loadCpp("ResultDto",jdc[0].toObject());
    }
}


void JsonFormartHelper::loadCpp(const QString& name,const QJsonObject &object){
    QFile fileHeader(AppConfig::instance()->getJsonClassDir()+"/"+name+".h");
    if(fileHeader.open(QIODevice::WriteOnly |QIODevice::Text)){
        QTextStream stream(&fileHeader);
        stream<<QString("#pragma once")<<"\n";
        stream<<QString("#include <infrastructure/nlohmann/json.h>")<<"\n";
        stream<<QString("struct %1").arg(name)<<"\n";
        stream<<QString("{").arg(name)<<"\n";
        QJsonObject::const_iterator it = object.constBegin();
        QJsonObject::const_iterator end = object.constEnd();
        QString nlohmannStr = QString::fromStdString("NLOHMANN_DEFINE_TYPE_NON_INTRUSIVE_WITH_DEFAULT(%1").arg(name);
        while (it != end) {
            const QJsonValue& value = it.value();
            const QString& key = it.key();
            nlohmannStr.append(QString(",%1").arg(key));
            if(value.isObject()){
                loadCpp(key,it.value().toObject());
                stream<<QString("%1 %1;").arg(key)<<"\n";
            }else if(value.isString()){
                stream<<QString("std::string %1;").arg(key)<<"\n";
            }else if(value.isBool()){
                stream<<QString("bool %1;").arg(key)<<"\n";
            }else if(value.isDouble()){
                stream<<QString("int %1;").arg(key)<<"\n";
            }else if(value.isArray()){
                auto arr = value.toArray();
                if(!arr.isEmpty()){
                    auto item = arr[0];
                    if(item.isObject()){
                        loadCpp(key,arr[0].toObject());
                        stream<<QString("std::vector<%1> %1;").arg(key)<<"\n";
                    }else if(item.isString()){
                        stream<<QString("std::vector<std::string> %1;").arg(key)<<"\n";
                    }else if(item.isBool()){
                        stream<<QString("std::vector<bool> %1;").arg(key)<<"\n";
                    }else if(item.isDouble()){
                        stream<<QString("std::vector<int> %1;").arg(key)<<"\n";
                    }else{
                        stream<<QString("std::vector<any> %1;").arg(key)<<"\n";
                    }
                }else{
                     stream<<QString("std::vector<any> %1;").arg(key)<<"\n";
                }
            }else{
                stream<<QString("std::any %1;").arg(key)<<"\n";
            }
            it++;
        }
        nlohmannStr.append(");");
        stream<<QString("};").arg(name)<<"\n";
        stream<<nlohmannStr<<"\n";
        fileHeader.close();
    }
}

void JsonFormartHelper::openDir(){
    QDesktopServices::openUrl(QUrl("file:///"+AppConfig::instance()->getJsonClassDir()));
}
