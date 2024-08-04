# Node.js 20をベースイメージとして使用
FROM node:20-alpine

# 作業ディレクトリを設定
WORKDIR /app

# bashをインストール
RUN apk update && apk add --no-cache bash

# アプリケーションディレクトリの所有者をnodeユーザーに変更
RUN chown -R node:node /app

# パッケージファイルをコピー
COPY --chown=node:node package*.json ./

# nodeユーザーに切り替え
USER node

# 依存関係をインストール
RUN npm install

# プロジェクトファイルをコピー
COPY --chown=node:node . .

# ポート5173を公開
EXPOSE 5173

# 開発サーバーを起動
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
