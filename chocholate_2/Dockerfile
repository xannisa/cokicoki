# Stage 1: Install dependencies
FROM node:20-alpine AS deps
WORKDIR /app

COPY app/package.json ./
RUN npm install

# Stage 2: Build the app
FROM node:20-alpine AS builder
WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY app/ ./

RUN npm run build

# Stage 3: Production image
FROM node:20-alpine AS runner
WORKDIR /app

ENV NODE_ENV=production

# Copy only necessary files
COPY --from=builder /app ./

EXPOSE 3000

CMD ["npm", "start"]
