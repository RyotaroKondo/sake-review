# c - 引数として受け取ったコンテナをいれる変数
c=
PROJECT=sake-review
DOCKER=docker
LOGS=$(DOCKER) logs $(PROJECT)-$(c)
PS=$(DOCKER) ps
COMPOSE=$(DOCKER)-compose
EXEC=$(DOCKER) exec -ti $(PROJECT)-$(c) /bin/bash
BUILD=$(COMPOSE) build $(c)
START=$(COMPOSE) up -d --build $(c)
UP=$(COMPOSE) up -d $(c)
STOP=$(COMPOSE) stop $(c)
DOWN=$(COMPOSE) down --rmi all --remove-orphans
NONE=`$(DOCKER) images -f "dangling=true" -q`

# sake-reviewに関連するコンテナの情報を確認するタスク
ps:
	@$(PS) | grep $(PROJECT)
# sake-reviewに関連する立ち上がっているコンテナの数を表示するタスク
ps/count:
	@$(PS) | grep $(PROJECT) | wc -l
# コンテナをビルドして立ち上げるタスク
start:
	@$(START)
# コンテナを立ち上げるタスク
up:
	@$(UP)
# コンテナを落とすタスク
stop:
	@$(STOP)
# コンテナを削除するタスク
down:
	@$(DOWN)
# noneイメージを一括削除するタスク
rm/none:
	@$(DOCKER) rmi -f $(NONE)
# コンテナ内に入るタスク（他のタスクを実行するために必要。単体では実行できない。）
exec:
	@$(EXEC)
# nginxコンテナの中に入るタスク
exec/nginx:
	@make exec c=nginx
# mysqlコンテナの中に入るタスク
exec/db:
	@make exec c=mysql
# backendコンテナの中に入るタスク
exec/laravel:
	@make exec c=backend
# frontendコンテナの中に入るタスク
exec/react:
	@make exec c=frontend
# reactのライブラリをインストールするタスク
exec/react/install:
	@$(DOCKER) exec -ti $(PROJECT)-frontend yarn install
# コンテナのログを出力するタスク（他のタスクを実行するために必要。単体では実行できない。）
logs:
	@$(LOGS)
# nginxのログを出力するタスク
logs/nginx:
	@make logs c=nginx
# mysqlのログを出力するタスク
logs/db:
	@make logs c=mysql
# backendのログを出力するタスク
logs/laravel:
	@make logs c=backend
# frontendのログを出力するタスク
logs/react:
	@make logs c=frontend
# コンテナをリビルドして立ち上げるタスク（他のタスクを実行するために必要。単体では実行しないほうが良い。）
re:
	@$(STOP)
	@$(BUILD)
	@$(UP)
# nginxのコンテナをリビルドして立ち上げるタスク
rebuild/nginx:
	@make re c=nginx
# mysqlのコンテナをリビルドして立ち上げるタスク
rebuild/db:
	@make re c=mysql
# backendのコンテナをリビルドして立ち上げるタスク
rebuild/laravel:
	@make re c=backend
# frontendのコンテナをリビルドして立ち上げるタスク
rebuild/react:
	@make re c=frontend
# 全てのコンテナをリスタートするタスク
restart: stop up
# 全てのコンテナを再ビルドして立ち上げるタスク
rebuild: down start