FROM node:22-alpine
WORKDIR /app
COPY backend/package*.json ./backend/
RUN npm ci --prefix backend --omit=dev
COPY backend ./backend
COPY frontend ./frontend
ENV NODE_ENV=production PORT=3000 HOST=0.0.0.0 DATA_FILE=/app/data/tasks.json
EXPOSE 3000
RUN addgroup -S taskflow && adduser -S taskflow -G taskflow && mkdir -p /app/data && chown -R taskflow:taskflow /app
USER taskflow
CMD ["node", "backend/src/server.js"]
