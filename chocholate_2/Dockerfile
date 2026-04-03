# Stage 1: Install dependencies
FROM node:20-alpine AS deps
WORKDIR /app
COPY app/package.json ./
RUN npm install

# Stage 2: Build
FROM node:20-alpine AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY app/ ./
RUN npm run build

# Stage 3: Production
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production

COPY --from=builder /app ./

EXPOSE 3000

# Add healthcheck (checks if app responds)
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD wget -qO- http://localhost:3000 || exit 1

CMD ["npm", "start"]