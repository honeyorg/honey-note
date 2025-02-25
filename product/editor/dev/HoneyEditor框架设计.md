# 目标

提供一个运行时编辑器框架，支持数据存储、API后端接口封装、网络通信、数据接入、Gameplay等功能。

# 系统架构设计

## 核心模块

### HoneyCore

核心模块，用于定义通用的功能子模块。如线程池、通信中心、插件配置等

### HoneyDB

数据库模块，负责数据库的管理，包括数据的增删改查操作，需支持SQLite3和MySQL

### HoneyDrogon

第三方库模块，用于集成Drogon

### HoneyBackend

后端模块，负责提供文件服务器、RestfulAPI封装注册接口等后端交互能力

### HoneyUI

前端UI模块，负责提供丰富的通用UI组件

### HoneyGameplay

Gameplay模块，负责实现GameInstance，管理子系统，虚拟机等。

### HoneyToolset

工具集，提供多元化工具。如audio，video，web page，截图工具，录屏，推流。

### HoneyAPI

根据实际的编辑器所需的通用业务封装的接口，设计要能区分Lite和Pro版本，支持动态注册，分化到二次开发的模块去（针对项目进行定制开发，但又不能影响产品框架性，为其提供一种灵活的框架设计）

### HoneyEditor

编辑器模块，依赖上述各模块，通过API接口进行数据接入，使得编辑器定制UI上可视化所有数据，并提供交互能力，在交互过程中调用API接口。