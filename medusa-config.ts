import { loadEnv, defineConfig } from '@medusajs/framework/utils'
loadEnv(process.env.NODE_ENV || 'development', process.cwd())

module.exports = defineConfig({
  projectConfig: {
    databaseUrl: process.env.DATABASE_URL,
    redisUrl: process.env.REDIS_URL,
    http: {
      storeCors: process.env.STORE_CORS!,
      adminCors: process.env.ADMIN_CORS!,
      authCors: process.env.AUTH_CORS!,
      jwtSecret: process.env.JWT_SECRET || "supersecret",
      cookieSecret: process.env.COOKIE_SECRET || "supersecret",
    }
  },
  admin: {
    disable: true,
    backendUrl: process.env.MEDUSA_BACKEND_URL,
  },
  plugins: [
    {
      resolve: `medusa-file-cloudinary`,
      options: {
        cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
        api_key: process.env.CLOUDINARY_API_KEY,
        api_secret: process.env.CLOUDINARY_API_SECRET,
        secure: true,
      },
    },
  ],
  modules: [
    {
      resolve: "@medusajs/medusa/payment",
      options: {
        providers: [
          {
            resolve: "@medusajs/medusa/payment-stripe",
            id: "stripe",
            options: {
              apiKey: process.env.STRIPE_API_KEY,
            },
          },
        ],
      },
    },
  ],
})
```

N'oublie pas :

1. `npm install medusa-file-cloudinary` dans ton projet
2. Ajouter les variables dans ton `.env` et sur Railway :
```
CLOUDINARY_CLOUD_NAME=dg3d9mrrp
CLOUDINARY_API_KEY=868627955876176
CLOUDINARY_API_SECRET=gcWBxdnVkaD-Mpr0_PCNqRGzj8o
