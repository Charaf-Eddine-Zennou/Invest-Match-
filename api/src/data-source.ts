

import { DataSource } from 'typeorm';
import * as dotenv from 'dotenv';
import path from 'path';

dotenv.config();

export const AppDataSource = new DataSource({
  type: 'mysql', 
  host: process.env.DATABASE_HOST,
  port: Number(process.env.DATABASE_PORT),
  username: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASSWORD,
  database: process.env.DATABASE_NAME,
  synchronize: false, 
  logging: false,
  entities: [path.join(__dirname, 'entities/**/*.ts')],
  migrations: [path.join(__dirname, 'migrations/**/*.ts')],
  migrationsTableName: 'migrations',
});

AppDataSource.initialize()
  .then(() => {
    console.log('Data Source has been initialized!');
  })
  .catch(error => console.log('Error initializing Data Source:', error));
