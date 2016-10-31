#/usr/bin/bash
ENV=""
if [ -z "$NODE_ENV" ]
then
  NODE_ENV="development"
fi

sequelize migration:create --config ./config/$NODE_ENV/database.json