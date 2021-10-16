import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class AppService {
  constructor(private readonly config: ConfigService) {}

  getHello(): string {
    return `Hello World! version: "${this.getVersion()}"`;
  }

  private getVersion(): string {
    const version = this.config.get<string>('VERSION');
    const buildNumber = this.config.get<string>('BUILD_NUMBER');
    if (buildNumber) {
      return `${version}-${buildNumber}`;
    }
    return version;
  }
}
