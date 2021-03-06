# 蓝牙UI Demo

- [蓝牙UI Demo](#%e8%93%9d%e7%89%99ui-demo)
  - [简介](#%e7%ae%80%e4%bb%8b)
  - [工程说明](#%e5%b7%a5%e7%a8%8b%e8%af%b4%e6%98%8e)
    - [依赖库](#%e4%be%9d%e8%b5%96%e5%ba%93)
    - [运行环境](#%e8%bf%90%e8%a1%8c%e7%8e%af%e5%a2%83)
    - [内容](#%e5%86%85%e5%ae%b9)
    - [硬件使用](#%e7%a1%ac%e4%bb%b6%e4%bd%bf%e7%94%a8)
    - [运行](#%e8%bf%90%e8%a1%8c)
    - [页面展示](#%e9%a1%b5%e9%9d%a2%e5%b1%95%e7%a4%ba)

## 简介 

本工程主要集成了`EnterBioModuleBLEUI`的UI库，展示UI库的集成方式。

## 工程说明

### 依赖库

UI SDK请参见[EnterBioModuleBLEUI](../EnterBioModuleBLEUI/)。

Demo使用`Cocopods`管理依赖库，使用前要先对工程主目录运行`pod install`。

### 运行环境

Xcode 11, iOS 13

### 内容

本工程展示了`EnterBioModuleBLEUI`库的蓝牙连接，固件升级，通过mac地址连接等功能。其中本Demo无硬件模拟，如需要设备请与合作方洽谈。

### 硬件使用

关于硬件的操作，请参考[回车生物电采集模块操作说明](https://docs.affectivecloud.com/%F0%9F%93%B2%E8%93%9D%E7%89%99%E9%87%87%E9%9B%86%E6%A8%A1%E5%9D%97/%E5%9B%9E%E8%BD%A6%E7%94%9F%E7%89%A9%E7%94%B5%E8%93%9D%E7%89%99%E9%87%87%E9%9B%86%E6%A8%A1%E5%9D%97%E6%93%8D%E4%BD%9C%E8%AF%B4%E6%98%8E.html)。

硬件使用的注意事项，请参考[回车生物电采集模块使用注意事项](https://docs.affectivecloud.com/%F0%9F%93%B2%E8%93%9D%E7%89%99%E9%87%87%E9%9B%86%E6%A8%A1%E5%9D%97/%E5%9B%9E%E8%BD%A6%E8%93%9D%E7%89%99%E7%94%9F%E7%89%A9%E7%94%B5%E9%87%87%E9%9B%86%E6%A8%A1%E5%9D%97%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.html)。

### 运行

运行本工程，点击`Show Navigation`按钮，UI库所集成的`BLEConnectViewController`会以模态的形式出现，自带导航栏，会自动管理navigation栈的层级。

### 页面展示

管理界面（只有多设备才有）

<img src="https://github.com/Entertech/Enter-Biomodule-BLE-iOS-SDK/blob/master/img/IMG_0834.PNG" width="300">

提示界面

<img src="https://github.com/Entertech/Enter-Biomodule-BLE-iOS-SDK/blob/master/img/IMG_0836.PNG" width="300">

连接界面

<img src="https://github.com/Entertech/Enter-Biomodule-BLE-iOS-SDK/blob/master/img/IMG_0835.PNG" width="300">

