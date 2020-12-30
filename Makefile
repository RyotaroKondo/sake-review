# c - コンテナ
c=""

# コンテナを立ち上げるタスク
start:
    docker-compose up -d --build
# コンテナを落とすタスク
down:
    docker-compose down
# コンテナ内に入るタスク
exec:
    docker exec -ti $(c) /bin/bash
# コンテナのログを出力するタスク
logs:
    docker logs $(c)
# コンテナを再ビルドして立ち上げるタスク
rebuild: down start