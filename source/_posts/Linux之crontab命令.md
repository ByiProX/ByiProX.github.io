---
title: Linux之crontab命令
date: 2018-05-05 23:24:12
tags:
  - Linux/Mac OS
categories:
  - Linux/Mac OS
---
## tldr 基本用法
```bash
Schedule cron jobs to run on a time interval for the current user.
Job definition format: "(min) (hour) (day_of_month) (month) (day_of_week) command_to_execute".

- Edit the crontab file for the current user:
    crontab -e

- View a list of existing cron jobs for current user:
    crontab -l

- Remove all cron jobs for the current user:
    crontab -r

- Sample job which runs at 10:00 every day. * means any value:
    0 10 * * * path/to/script.sh

- Sample job which runs every minute on the 3rd of April:
    * * 3 Apr * path/to/script.sh

- Sample job which runs at 02:30 every Friday:
    30 2 * * Fri path/to/script.sh
```
<!-- more -->
## 时间格式
crontab通过固定的的时间设置格式设置任务的执行时间
```python
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
```
第一个参数代表分，其次是小时，然后是日期，之后是月份，最后是所在周的周几。各个字段可以使用特殊字符来代表时间逻辑。

```python
星号（*）：        代表所有可能的值，例如month字段如果是星号，则表示在满足其它字段的制约条件后每月都执行该命令操作。
逗号（a,b,c）： 可以用逗号隔开的值指定一个列表范围，例如，“1,2,5,7,8,9”
中杠（x-y）：    可以用整数之间的中杠表示一个整数范围，例如“2-6”表示“2,3,4,5,6”
正斜线（/）：    可以用正斜线指定时间的间隔频率，例如“0-23/2”表示每两小时执行一次。
组合（*/x）：    指定时间类型下，每x分钟或每小时执行一次
组合(x-y/z)：    指定时间类型下，从x到y时间段内，每z分或每z秒执行一次
```
如果是当前用户设置自己的定时任务，可以直接通过crontab -e编辑任务，命令格式* * * * * command即可。
编辑好任务需要重启crontab，注意需要以root身份执行。
