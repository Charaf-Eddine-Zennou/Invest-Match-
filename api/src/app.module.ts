import { Module } from '@nestjs/common';
import { APP_INTERCEPTOR } from '@nestjs/core';
import { TypeOrmModule } from '@nestjs/typeorm';
import { WinstonModule } from 'nest-winston';
import { MysqlConnectionOptions } from 'typeorm/driver/mysql/MysqlConnectionOptions'; 
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AppDataSource } from './data-source';
import { User } from './entities/user.entity';
import { loggerConf } from './logger';
import { UserController } from './users/user.controller';
import { UserService } from './users/user.service';
import { CompaniesModule } from './companies/companies.module';
import { FeedbackModule } from './feedback/feedback.module';
import { MatchModule } from './match/match.module';
import { CommentModule } from './comment/comment.module';
import { MessageModule } from './message/message.module';


@Module({
  imports: [
    TypeOrmModule.forRoot({
      ...(AppDataSource.options as MysqlConnectionOptions), 
      synchronize: AppDataSource.options.synchronize,
      logging: AppDataSource.options.logging,
    }),
    TypeOrmModule.forFeature([User]),
    WinstonModule.forRoot(loggerConf),
    CompaniesModule,
    FeedbackModule,
    MatchModule,
    CommentModule,
    MessageModule,
    
  ],
  controllers: [AppController, UserController],
  providers: [
    AppService,
    UserService,
  ],
})
export class AppModule {}
