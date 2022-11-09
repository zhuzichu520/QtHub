#include "RepositoriesService.h"


QList<Repositories> RepositoriesService::search(const QString& q,const QString& sort,const QString& order,int per_page,int page){
   return repository->search(q,sort,order,per_page,page);
}
