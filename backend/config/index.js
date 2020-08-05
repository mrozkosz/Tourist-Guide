require('dotenv').config({
    path: process.env.NODE_ENV === 'test' ? '.env.test' : '.env'
});

const env = (key, defaultValue = null) => process.env[key] || defaultValue;
const isEnabled = (key) => env(key) && env(key) === 'true';

const config = {
    db: {
        url: env('DATABASE_URL'),
        logging: isEnabled('SEQUELIZE_LOGGING') ? console.log : false,
        define: {
            charset: 'utf8mb4',
            collate: 'utf8mb4_unicode_ci',
            timestamps: false
        }
    },
    auth: {
        expiresIn: env('JWT_EXPIRES_IN'),
        secretKey: env('JWT_SECRET_KEY')
    },
    password: {
        expiresIn: env('JWT_RECOVER_EXPIRES_IN')
    },
    email: {
        host: env('EMAIL_HOST'),
        port: env('EMAIL_PORT'),
        secure: env('EMAIL_SECURE'),
        auth: {
            user: env('EMAIL_AUTH_USER'),
            pass: env('EMAIL_AUTH_PASSWORD')
        }
    },
    app: {
        frontendUrl: env('APP_FRONTEND_URL'),
        appUrl: env('APP_URL'),
        corsSites: env('APP_CORS_SITES', '')
    }
};
module.exports = config;
